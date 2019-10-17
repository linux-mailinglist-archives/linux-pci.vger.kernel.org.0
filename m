Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1C741DB774
	for <lists+linux-pci@lfdr.de>; Thu, 17 Oct 2019 21:26:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2503493AbfJQT0S (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 17 Oct 2019 15:26:18 -0400
Received: from mail.kernel.org ([198.145.29.99]:42596 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2393438AbfJQT0S (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 17 Oct 2019 15:26:18 -0400
Received: from localhost (unknown [69.71.4.100])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EB44E20869;
        Thu, 17 Oct 2019 19:26:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1571340377;
        bh=E1IMidIFIGHKqHdOBlCnWZ2bTAQeqDmbNUfulv783io=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=qOSVqRz6n3cM0XoiN4A8DYjLyH42LPOzvPWldVUFwKYQV1ZRup4/F919H+2JHbW1b
         Qt7RD701BvbvndZh+8U2bSxxdl/ed3NVSQuZVoMVdZLePgjjiKNaN5nH8M7pe7mJgv
         tPYp7GC19DL4iJykJ0DUYoSnH/4TkerCWhpJ1qnc=
Date:   Thu, 17 Oct 2019 14:26:15 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     kbuild test robot <lkp@intel.com>
Cc:     kbuild-all@lists.01.org, linux-pci@vger.kernel.org,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [pci:pci/pm 4/7] drivers/pci/pci-driver.c:1348:2: error:
 implicit declaration of function 'pci_pm_default_resume'; did you mean
 'pci_pm_runtime_resume'?
Message-ID: <20191017192615.GA240632@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <201910170851.fNrXjGg1%lkp@intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Oct 17, 2019 at 08:59:56AM +0800, kbuild test robot wrote:
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci.git pci/pm
> head:   d17ff4ab7daac4bf26d59a4de3ca22f42492425b
> commit: 6d133f6f1934493a0dc0504fa115e5140d010522 [4/7] PCI/PM: Run resume fixups before disabling wakeup events
> config: ia64-allmodconfig (attached as .config)
> compiler: ia64-linux-gcc (GCC) 7.4.0
> reproduce:
>         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         git checkout 6d133f6f1934493a0dc0504fa115e5140d010522
>         # save the attached .config to linux build tree
>         GCC_VERSION=7.4.0 make.cross ARCH=ia64 
> 
> If you fix the issue, kindly add following tag
> Reported-by: kbuild test robot <lkp@intel.com>
> 
> All errors (new ones prefixed by >>):
> 
>    drivers/pci/pci-driver.c: In function 'pci_pm_runtime_resume':
> >> drivers/pci/pci-driver.c:1348:2: error: implicit declaration of function 'pci_pm_default_resume'; did you mean 'pci_pm_runtime_resume'? [-Werror=implicit-function-declaration]
>      pci_pm_default_resume(pci_dev);
>      ^~~~~~~~~~~~~~~~~~~~~
>      pci_pm_runtime_resume
>    cc1: some warnings being treated as errors

I think I fixed this by moving the pci_pm_default_resume() definition
as follows:

    pci_pm_default_resume() is called from pci_pm_runtime_resume(), which is
    under #ifdef CONFIG_PM.  If SUSPEND and HIBERNATION are disabled, PM_SLEEP
    is disabled also, so move pci_pm_default_resume() from #ifdef
    CONFIG_PM_SLEEP to #ifdef CONFIG_PM.

diff --git a/drivers/pci/pci-driver.c b/drivers/pci/pci-driver.c
index 55acb658273f..abee2a790a10 100644
--- a/drivers/pci/pci-driver.c
+++ b/drivers/pci/pci-driver.c
@@ -517,6 +517,12 @@ static int pci_restore_standard_config(struct pci_dev *pci_dev)
 	return 0;
 }
 
+static void pci_pm_default_resume(struct pci_dev *pci_dev)
+{
+	pci_fixup_device(pci_fixup_resume, pci_dev);
+	pci_enable_wake(pci_dev, PCI_D0, false);
+}
+
 #endif
 
 #ifdef CONFIG_PM_SLEEP
@@ -645,12 +651,6 @@ static int pci_legacy_resume(struct device *dev)
 
 /* Auxiliary functions used by the new power management framework */
 
-static void pci_pm_default_resume(struct pci_dev *pci_dev)
-{
-	pci_fixup_device(pci_fixup_resume, pci_dev);
-	pci_enable_wake(pci_dev, PCI_D0, false);
-}
-
 static void pci_pm_default_suspend(struct pci_dev *pci_dev)
 {
 	/* Disable non-bridge devices without PM support */
@@ -992,7 +992,6 @@ static int pci_pm_resume(struct device *dev)
 
 #ifdef CONFIG_HIBERNATE_CALLBACKS
 
-
 /*
  * pcibios_pm_ops - provide arch-specific hooks when a PCI device is doing
  * a hibernate transition
