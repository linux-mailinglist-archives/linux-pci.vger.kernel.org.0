Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 86E7A3E4C53
	for <lists+linux-pci@lfdr.de>; Mon,  9 Aug 2021 20:46:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234842AbhHISrB (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 9 Aug 2021 14:47:01 -0400
Received: from mail.kernel.org ([198.145.29.99]:33882 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230175AbhHISrB (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 9 Aug 2021 14:47:01 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 9695360EE7;
        Mon,  9 Aug 2021 18:46:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1628534800;
        bh=q/KG5CuyzipyhIL40MTt4fBKdRKvIPZ8GfXe0U47XKc=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=gS/sbT3n8w5hJqd8DkCQZOSFgDXmEwMPudkHwolLv6KBhhiHAi+kBgGzab54pZN54
         RMDMFsTyq/uRcCqE4KOQXw0rnZfHZR6gvIIlx8ONkXJF6kCLRtWYToa2pzBmFYjLXz
         iR+3ZnQ1SF7vK7w8SlckP8YIPg31knRsIUaX+N+qB6PtvnR/sBsvT7si+T4XlPF9va
         z6nJeaa2CEnT7oX54zGCpk69TKn9nQDcyo3sEOqe/cY1KJRPG4VtjcMJXCrbCsCNA+
         7hqp0uGinhqIhAO9FN+ggQRRMqe9oBCjW5B19NdTTuiVu2GDJBRyHGn9zgc11/hoTR
         MjU5hpvIkzyQA==
Date:   Mon, 9 Aug 2021 13:46:39 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Qian Cai <quic_qiancai@quicinc.com>
Cc:     Heiner Kallweit <hkallweit1@gmail.com>,
        Hannes Reinecke <hare@suse.de>, linux-pci@vger.kernel.org,
        Bjorn Helgaas <bhelgaas@google.com>,
        Saeed Mahameed <saeedm@nvidia.com>,
        Leon Romanovsky <leon@kernel.org>
Subject: Re: [PATCH v2 4/6] PCI/VPD: Reject resource tags with invalid size
Message-ID: <20210809184639.GA2172096@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a20b07f5-6849-e4b6-82fa-ddf67693e104@quicinc.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Aug 09, 2021 at 02:15:20PM -0400, Qian Cai wrote:
> 
> 
> On 7/29/2021 2:42 PM, Bjorn Helgaas wrote:
> > From: Bjorn Helgaas <bhelgaas@google.com>
> > 
> > VPD is limited in size by the 15-bit VPD Address field in the VPD
> > Capability.  Each resource tag includes a length that determines the
> > overall size of the resource.  Reject any resources that would extend past
> > the maximum VPD size.
> > 
> > Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
> 
> + mlx5_core maintainers
> 
> Hi there, running the latest linux-next with this commit, our system started to
> get noisy. Could those indicate some device firmware bugs?
> 
> [  164.937191] mlx5_core 0000:01:00.0: invalid VPD tag 0x78 at offset 113
> [  165.933527] mlx5_core 0000:01:00.1: invalid VPD tag 0x78 at offset 113

Thanks a lot for reporting this!

I guess VPD contains a tag of 0x78, which is a small resource item
with name 0xf (an End Tag) and size 0.  Per PNPISA, the End Tag should
have a length 1, with the single byte being a checksum of the resource
data.  But the PCI spec doesn't mention that checksum byte, so I think
we should accept the size 0 without any message.

I think the following patch on top of linux-next should do this:

diff --git a/drivers/pci/vpd.c b/drivers/pci/vpd.c
index 5e2e638093f1..d7f705ba6664 100644
--- a/drivers/pci/vpd.c
+++ b/drivers/pci/vpd.c
@@ -69,12 +69,11 @@ EXPORT_SYMBOL(pci_write_vpd);
  */
 static size_t pci_vpd_size(struct pci_dev *dev)
 {
-	size_t off = 0;
-	unsigned char header[1+2];	/* 1 byte tag, 2 bytes length */
+	size_t off = 0, size;
+	unsigned char tag, header[1+2];	/* 1 byte tag, 2 bytes length */
 
 	while (pci_read_vpd(dev, off, 1, header) == 1) {
-		unsigned char tag;
-		size_t size;
+		size = 0;
 
 		if (off == 0 && (header[0] == 0x00 || header[0] == 0xff))
 			goto error;
@@ -95,7 +94,7 @@ static size_t pci_vpd_size(struct pci_dev *dev)
 			/* Short Resource Data Type Tag */
 			tag = pci_vpd_srdt_tag(header);
 			size = pci_vpd_srdt_size(header);
-			if (size == 0 || off + size > PCI_VPD_MAX_SIZE)
+			if (off + size > PCI_VPD_MAX_SIZE)
 				goto error;
 
 			off += PCI_VPD_SRDT_TAG_SIZE + size;
@@ -106,8 +105,8 @@ static size_t pci_vpd_size(struct pci_dev *dev)
 	return off;
 
 error:
-	pci_info(dev, "invalid VPD tag %#04x at offset %zu%s\n",
-		 header[0], off, off == 0 ?
+	pci_info(dev, "invalid VPD tag %#04x (size %zu) at offset %zu%s\n",
+		 header[0], size, off, off == 0 ?
 		 "; assume missing optional EEPROM" : "");
 	return off;
 }
