Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 787AC419258
	for <lists+linux-pci@lfdr.de>; Mon, 27 Sep 2021 12:41:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233819AbhI0Km4 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 27 Sep 2021 06:42:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233800AbhI0Km4 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 27 Sep 2021 06:42:56 -0400
X-Greylist: delayed 474 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 27 Sep 2021 03:41:18 PDT
Received: from lony.xyz (lony.xyz [IPv6:2a01:7e01::f03c:92ff:fe99:4b59])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47C11C061575;
        Mon, 27 Sep 2021 03:41:18 -0700 (PDT)
Received: from localhost (unknown [170.253.2.75])
        by lony.xyz (Postfix) with ESMTPSA id 689131F9BC;
        Mon, 27 Sep 2021 10:33:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lony.xyz; s=mail;
        t=1632738802; bh=nKMFTgo5CanCRiqXgTJW+InJx6nUU/was8hOu/PSPBE=;
        h=Date:From:To:Cc:Subject:From;
        b=ph98J9AfNC0LGnydbzRfBvTdGv5TCfHP6lu8XrNdiGoY8A8wDlFbV/iLYWWvSTuiD
         YhN1vtvJ08/xMaVmzoWTpV0oNKglL/qVPTWD+hMta7DmAW6I0PGgfsgOzgVKexI9tk
         krvnbDiStI0mYRvBvU/MpC1kKkeTVb4coCTAV+AKZ9v+5OO4zTyzwV8U2XD8soBu7y
         9nKCWegbm56Ed3jBjOxW1IOTdqjrJYMIHReKtNKKyYQreLw0G3E8NLk5HuRw3/2R/6
         Ks24jSRYpA9qbi9JT6qhw8ZSTeq28jh5weYyq5XwIyI+ar0nL/AT79TNQVrpYQt6+R
         irCSB9MgM7SMQ==
Date:   Mon, 27 Sep 2021 12:33:21 +0200
From:   "Sergio M. Iglesias" <sergio@lony.xyz>
To:     bhelgaas@google.com
Cc:     lorenzo.pieralisi@arm.com, robh@kernel.org, kw@linux.com,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: About the "__refdata" tag in pci-keystone.c
Message-ID: <20210927103321.v4kod7xfiv5sreet@lony.xyz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hello!

I have checked the "__refdata" tag that appears in the file
"drivers/pci/controller/dwc/pci-keystone.c" and it is needed. The tag has
been there since the creation of the file on commit 6e0832fa432e and
nothing has changed since that would make it redundant.

The reason it is needed is because the struct references "ks_pcie_probe",
which is a function tagged as "__init", so the compiler will most likely
complain about the "__refdata" being removed.

Should I send a patch to add a comment explaining why it is a necessary
tag as recommended in "include/linux/init.h"?
> [...] so optimally document why the __ref is needed and why it's OK).

Thanks for your time,
Sergio M. Iglesias.
