Return-Path: <linux-pci+bounces-5266-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BCEE88E8F7
	for <lists+linux-pci@lfdr.de>; Wed, 27 Mar 2024 16:27:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 188911F2B791
	for <lists+linux-pci@lfdr.de>; Wed, 27 Mar 2024 15:27:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27A5A383A3;
	Wed, 27 Mar 2024 15:23:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="O4I/BuHF"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01D822557E;
	Wed, 27 Mar 2024 15:23:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711553012; cv=none; b=VEn40nRgzcESJz/j5jJ+We94A+eJq7La4I8BgNLcKcboeuy7OSwX1QfHvoWNFXnFjnAGDn88xEEm23AXbTiPn2g5Uf7Fap2XEkKGiTSoZCQnu9WyOLCF0I6qmqzxCVY1mFBuPZ6V+AhWkGI788I43DSJhZq0Z10FH0uuApekn98=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711553012; c=relaxed/simple;
	bh=rMv9zxTLOc2gGvdPWGvZBa+aQKrI/aFqAI1di8hyPQw=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=idO9ycIoWQ2HzKMYsekE8aBNp/aPYjirj4H/K7o0i3yTzQ500KA8HX2xG4HMbZb59K+ybOk3VW/Zekd71YTNGeyE/6NTtWQd25EbKWljv/EImkEd4Ol5pQ+PpKmEs/sXcBT4unxuIRxVOmSljpwRTIVDMrvHCF+I7HA46sH5+sk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=O4I/BuHF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 91063C433A6;
	Wed, 27 Mar 2024 15:23:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711553011;
	bh=rMv9zxTLOc2gGvdPWGvZBa+aQKrI/aFqAI1di8hyPQw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=O4I/BuHF490WGur6hj5s8qbEij6Vu/xefRx3Pyhni6+LsfYGaZfW3nPTgP0r7OM6A
	 4nMvSHfuaGAJYusAVP4Nlohpk+FgMGiFegJX7o1dEDkcRSJqnoTHZJ5YUZ+pTXpzh6
	 aU5D+Ql/lbKdFFRdw/x4Was5dUMa0oSJ5mcZ5lFcfy5R5ufKGcmvOoUkcxJBKv48uL
	 pqWsWxPw+KPEYpQKC2dpv+1rSBqAnaCpJePtwyOjtXouLguEM684QgLpFLS+hpvt9P
	 WBYTKlV2tJ5m256ffDvs0Mw50yTMAALhp+W6H9b63vY2N0hqA8sypxb2NywF96YlEZ
	 8lTlFNZdhpF1A==
Date: Wed, 27 Mar 2024 10:23:29 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Kai-Heng Feng <kai.heng.feng@canonical.com>
Cc: bhelgaas@google.com, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Victor Shih <victor.shih@genesyslogic.com.tw>,
	Ben Chuang <benchuanggli@gmail.com>
Subject: Re: [PATCH v3] PCI: Mask replay timer timeout of GL975x's rootport
Message-ID: <20240327152329.GA1523226@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240327024509.1071189-1-kai.heng.feng@canonical.com>

On Wed, Mar 27, 2024 at 10:45:09AM +0800, Kai-Heng Feng wrote:
> Any access to GL975x's config space, like `lspci -vv` or
> pci_save_state(), can still trigger the replay timer timeout error even
> after commit 015c9cbcf0ad ("mmc: sdhci-pci-gli: GL9750: Mask the replay
> timer timeout of AER"), albeit with a lower reproduce rate.
> 
> The AER interrupt can prevent the system from suspending, or can flood
> the kernel message. So mask the replay timer timeout to resolve the
> issue.
> 
> Cc: Victor Shih <victor.shih@genesyslogic.com.tw>
> Cc: Ben Chuang <benchuanggli@gmail.com>
> Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>

Applied as below to pci/aer for v6.10, thanks!

commit eeee3b5e6d0b ("PCI: Mask Replay Timer Timeout errors for Genesys GL975x SD host controller")
Author: Kai-Heng Feng <kai.heng.feng@canonical.com>
Date:   Wed Mar 27 10:45:09 2024 +0800

    PCI: Mask Replay Timer Timeout errors for Genesys GL975x SD host controller
    
    Due to a hardware defect in GL975x, config accesses when ASPM is enabled
    frequently cause Replay Timer Timeouts in the Port leading to the device.
    
    These are Correctable Errors, so the Downstream Port logs it in its AER
    Correctable Error Status register and, when the error is not masked, sends
    an ERR_COR message upstream.  The message terminates at a Root Port, which
    may generate an AER interrupt so the OS can log it.
    
    The Correctable Error logging is an annoyance but not a major issue itself.
    But when the AER interrupt happens during suspend, it can prevent the
    system from suspending.
    
    015c9cbcf0ad ("mmc: sdhci-pci-gli: GL9750: Mask the replay timer timeout of
    AER") masked these errors in the GL975x itself.
    
    Mask these errors in the Port leading to GL975x as well.  Note that Replay
    Timer Timeouts will still be logged in the AER Correctable Error Status
    register, but they will not cause AER interrupts.
    
    Link: https://lore.kernel.org/r/20240327024509.1071189-1-kai.heng.feng@canonical.com
    Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
    [bhelgaas: commit log, update dmesg note]
    Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
    Cc: Victor Shih <victor.shih@genesyslogic.com.tw>
    Cc: Ben Chuang <benchuanggli@gmail.com>


diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
index bf4833221816..5cb0f7fae3b8 100644
--- a/drivers/pci/quirks.c
+++ b/drivers/pci/quirks.c
@@ -6261,3 +6261,23 @@ static void pci_fixup_d3cold_delay_1sec(struct pci_dev *pdev)
 	pdev->d3cold_delay = 1000;
 }
 DECLARE_PCI_FIXUP_FINAL(0x5555, 0x0004, pci_fixup_d3cold_delay_1sec);
+
+#ifdef CONFIG_PCIEAER
+static void pci_mask_replay_timer_timeout(struct pci_dev *pdev)
+{
+	struct pci_dev *parent = pci_upstream_bridge(pdev);
+	u32 val;
+
+	if (!parent || !parent->aer_cap)
+		return;
+
+	pci_info(parent, "mask Replay Timer Timeout Correctable Errors due to %s hardware defect",
+		 pci_name(pdev));
+
+	pci_read_config_dword(parent, parent->aer_cap + PCI_ERR_COR_MASK, &val);
+	val |= PCI_ERR_COR_REP_TIMER;
+	pci_write_config_dword(parent, parent->aer_cap + PCI_ERR_COR_MASK, val);
+}
+DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_GLI, 0x9750, pci_mask_replay_timer_timeout);
+DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_GLI, 0x9755, pci_mask_replay_timer_timeout);
+#endif

