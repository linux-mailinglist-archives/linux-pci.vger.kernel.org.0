Return-Path: <linux-pci+bounces-5455-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E5B5892B74
	for <lists+linux-pci@lfdr.de>; Sat, 30 Mar 2024 14:47:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B1F841C203DA
	for <lists+linux-pci@lfdr.de>; Sat, 30 Mar 2024 13:47:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A65D8BFC;
	Sat, 30 Mar 2024 13:46:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ERrgVHsw"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A67338DF1;
	Sat, 30 Mar 2024 13:46:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711806418; cv=none; b=juZik5Bo3fm9m1jKvwLH1o87B/SX7eozsFjUp0JZE1ct5QaanZkYhoAliIQztI5d2yYWHRh9DMiCtBAkj9lTD8eu9HwB5SydP1YPR9gjMO1kzPYc7gktTRsbYRphjrR4irA/Wg/hJhCdsLITXWh++Mhy6tfODLg5FsCiELT4baw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711806418; c=relaxed/simple;
	bh=12eUH24Evzx0eCQ4eL4gtrmRZMuYkNV0sF0qoZdQEXc=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=hjc01Kta3aksZuNQRlXrFqWUNFkg9lsEwwt3z14zQ1P4+pG3e7+6zdeu5Eu68YwhN2z5mZsrR/5V0YeqfNY7TfaRYiklS3QuE1G76LjxEQ4pvTbOoPZzaQDmEcy0S/Ia3nbrMqQz59pMudidLdZuvlrIzNEPuKLWVOSwwfXOgvA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ERrgVHsw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7E5A2C433C7;
	Sat, 30 Mar 2024 13:46:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711806417;
	bh=12eUH24Evzx0eCQ4eL4gtrmRZMuYkNV0sF0qoZdQEXc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=ERrgVHswUV6pqvGhHbMTzn4oCU+YAzaOxhif//9nUH7DGEgBQ8S255iMyvqxOW6x2
	 qlfMTCsIZox9vHvTReZaO+v2V/geKSAkEFwNuf/klLDOheaXs1KI3XAO8jUg3SxZHQ
	 kQOLxbeuOmG8AEgYhsiD2WGkWV1O8UJZVQkkrvatQwPwuMk7CNzPSjbbvfmsZYwcS7
	 Y65mtAtbWO39qXzNxbJUgEcdYCZmsjdtDImlwq75/b61B4FcH7ZIyIeWx8RN46eAN+
	 AXEaDR8QCHHNguF1vgatcDgNOdiUzJJWfIhBICz0L0/q7nUh9ct2k/mb5LtG1xnlbj
	 moJt+V4xAPhyg==
Date: Sat, 30 Mar 2024 08:46:55 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Bagas Sanjaya <bagasdotme@gmail.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Linux Regressions <regressions@lists.linux.dev>,
	Linux NVMe <linux-nvme@lists.infradead.org>,
	linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
	Chaitanya Kulkarni <kch@nvidia.com>, Christoph Hellwig <hch@lst.de>,
	gloriouseggroll@gmail.com, Keith Busch <kbusch@kernel.org>,
	Sagi Grimberg <sagi@grimberg.me>, Hannes Reinecke <hare@suse.de>,
	Kai-Heng Feng <kai.heng.feng@canonical.com>
Subject: Re: Fwd: Regression: Kernel 6.4 rc1 and higher causes Steam Deck to
 fail to wake from suspend (bisected)
Message-ID: <20240330134655.GA1659153@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231101114541.GA43502@bhelgaas>

[+cc Keith, Sagi, Hannes, Kai-Heng, +bcc silverspring from bugzilla]

On Wed, Nov 01, 2023 at 06:45:41AM -0500, Bjorn Helgaas wrote:
> On Tue, Oct 31, 2023 at 03:21:20PM +0700, Bagas Sanjaya wrote:
> > I notice a regression report on Bugzilla [1]. Quoting from it:
> > 
> > > On Kernel 6.4 rc1 and higher if you put the Steam Deck into
> > > suspend then press the power button again it will not wake up. 
> > > 
> > > I don't have a clue as to -why- this commit breaks wake from
> > > suspend on steam deck, but it does. Bisected to:
> > > 
> > > ```
> > > 1ad11eafc63ac16e667853bee4273879226d2d1b is the first bad commit
> > > commit 1ad11eafc63ac16e667853bee4273879226d2d1b
> > > Author: Bjorn Helgaas <bhelgaas@google.com>
> > > Date:   Tue Mar 7 14:32:43 2023 -0600
> > > 
> > >     nvme-pci: drop redundant pci_enable_pcie_error_reporting()
> > >     
> > >     pci_enable_pcie_error_reporting() enables the device to send ERR_*
> > >     Messages.  Since f26e58bf6f54 ("PCI/AER: Enable error reporting when AER is
> > >     native"), the PCI core does this for all devices during enumeration, so the
> > >     driver doesn't need to do it itself.
> > >     
> > >     Remove the redundant pci_enable_pcie_error_reporting() call from the
> > >     driver.  Also remove the corresponding pci_disable_pcie_error_reporting()
> > >     from the driver .remove() path.
> > >     
> > >     Note that this only controls ERR_* Messages from the device.  An ERR_*
> > >     Message may cause the Root Port to generate an interrupt, depending on the
> > >     AER Root Error Command register managed by the AER service driver.
> > >     
> > >     Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
> > >     Reviewed-by: Chaitanya Kulkarni <kch@nvidia.com>
> > >     Signed-off-by: Christoph Hellwig <hch@lst.de>
> > > 
> > >  drivers/nvme/host/pci.c | 6 +-----
> > >  1 file changed, 1 insertion(+), 5 deletions(-)
> > > ```

> > > Reverting that commit by itself on top of 6.5.9 (stable) allows
> > > it to wake from suspend properly.

> > [1]: https://bugzilla.kernel.org/show_bug.cgi?id=218090
> 
> Thanks, I requested some dmesg logs and lspci output to help debug
> this.

silverspring attached lspci output and a dmesg log from v6.8 to the
bugzilla and also noted that "pci=noaer" works around the problem.

The problem commit is 1ad11eafc63a ("nvme-pci: drop redundant
pci_enable_pcie_error_reporting()")
(https://git.kernel.org/linus/1ad11eafc63a)

1ad11eafc63a removed pci_disable_pcie_error_reporting() from the
nvme_suspend() path, so we now leave the PCIe Device Control error
enables set when we didn't before.  My theory is that the PCIe link
goes down during suspend, which causes an error interrupt, and the
interrupt causes a problem on Steam Deck.  Maybe there's some BIOS
connection.

"pci=noaer" would work around this because those error enables would
never be set in the first place.

I asked reporters to test the debug patches below to disable those
error interrupts during suspend.

I don't think this would be the *right* fix; if we need to do this, I
think it should be done by the PCI core, not by individual drivers.
Kai-Heng has been suggesting this for a while for a different
scenario.

Bjorn


commit 60c07557d0cc ("Revert "PCI/AER: Drop unused pci_disable_pcie_error_reporting()"")
Author: Bjorn Helgaas <bhelgaas@google.com>
Date:   Fri Mar 29 17:54:30 2024 -0500

    Revert "PCI/AER: Drop unused pci_disable_pcie_error_reporting()"
    
    This reverts commit 69b264df8a412820e98867dbab871c6526c5e5aa.


diff --git a/drivers/pci/pcie/aer.c b/drivers/pci/pcie/aer.c
index ac6293c24976..273f9c6f93dd 100644
--- a/drivers/pci/pcie/aer.c
+++ b/drivers/pci/pcie/aer.c
@@ -243,6 +243,18 @@ static int pci_enable_pcie_error_reporting(struct pci_dev *dev)
 	return pcibios_err_to_errno(rc);
 }
 
+int pci_disable_pcie_error_reporting(struct pci_dev *dev)
+{
+	int rc;
+
+	if (!pcie_aer_is_native(dev))
+		return -EIO;
+
+	rc = pcie_capability_clear_word(dev, PCI_EXP_DEVCTL, PCI_EXP_AER_FLAGS);
+	return pcibios_err_to_errno(rc);
+}
+EXPORT_SYMBOL_GPL(pci_disable_pcie_error_reporting);
+
 int pci_aer_clear_nonfatal_status(struct pci_dev *dev)
 {
 	int aer = dev->aer_cap;
diff --git a/include/linux/aer.h b/include/linux/aer.h
index 4b97f38f3fcf..425e5e430e65 100644
--- a/include/linux/aer.h
+++ b/include/linux/aer.h
@@ -40,9 +40,14 @@ struct aer_capability_regs {
 int pcie_read_tlp_log(struct pci_dev *dev, int where, struct pcie_tlp_log *log);
 
 #if defined(CONFIG_PCIEAER)
+int pci_disable_pcie_error_reporting(struct pci_dev *dev);
 int pci_aer_clear_nonfatal_status(struct pci_dev *dev);
 int pcie_aer_is_native(struct pci_dev *dev);
 #else
+static inline int pci_disable_pcie_error_reporting(struct pci_dev *dev)
+{
+	return -EINVAL;
+}
 static inline int pci_aer_clear_nonfatal_status(struct pci_dev *dev)
 {
 	return -EINVAL;
commit 8efb88cf23d4 ("nvme-pci: disable error reporting in nvme_dev_disable()")
Author: Bjorn Helgaas <bhelgaas@google.com>
Date:   Fri Mar 29 17:52:39 2024 -0500

    nvme-pci: disable error reporting in nvme_dev_disable()
    
    Debug patch.
    
    The PCI core enables error reporting in pci_aer_init() for all devices that
    advertise AER support.
    
    During suspend, nvme_suspend() calls nvme_dev_disable() in several cases.
    Prior to 1ad11eafc63a, nvme_dev_disable() disabled error reporting.
    
    After 1ad11eafc63a, error reporting will remain enabled during suspend.
    Maybe having error reporting enabled during suspend causes a problem on
    Steam Deck.
    
    "pci=noaer" prevents pci_aer_init() from enabling error reporting, so as
    long as the BIOS doesn't enable it, error reporting should always be
    disabled.
    
      nvme_suspend
        nvme_disable_prepare_reset
          nvme_dev_disable


diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index 8e0bb9692685..2be838b5d1f6 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -5,6 +5,7 @@
  */
 
 #include <linux/acpi.h>
+#include <linux/aer.h>
 #include <linux/async.h>
 #include <linux/blkdev.h>
 #include <linux/blk-mq.h>
@@ -2603,8 +2604,10 @@ static void nvme_dev_disable(struct nvme_dev *dev, bool shutdown)
 	nvme_suspend_io_queues(dev);
 	nvme_suspend_queue(dev, 0);
 	pci_free_irq_vectors(pdev);
-	if (pci_is_enabled(pdev))
+	if (pci_is_enabled(pdev)) {
+		pci_disable_pcie_error_reporting(pdev);
 		pci_disable_device(pdev);
+	}
 	nvme_reap_pending_cqes(dev);
 
 	nvme_cancel_tagset(&dev->ctrl);

