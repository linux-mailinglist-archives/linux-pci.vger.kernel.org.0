Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5892A454F87
	for <lists+linux-pci@lfdr.de>; Wed, 17 Nov 2021 22:43:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231839AbhKQVqU (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 17 Nov 2021 16:46:20 -0500
Received: from mail.kernel.org ([198.145.29.99]:53190 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233181AbhKQVqS (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 17 Nov 2021 16:46:18 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id A32A4613D3;
        Wed, 17 Nov 2021 21:43:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1637185398;
        bh=tzX4JOPsENdbcgPr+OLouNvGeSzeA5GfcWVRsT5SnMw=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=QveKeIGhoB4MU1v+4qxz1967IyM6LkY7/gIO7kfFctwmhzocco5wMWd0lbRmTU3NM
         /Hi+NLtVUBB8UO/upIbAboPfMB6XZg/EXeyt630jsHt1t/JumCAkMlhEFgT4uJJvuE
         3RV+2GVrlG2SQBAA8mRoGE28442H11jitYXplkFbQSLQvrxsj9V6DYg6bFfhp3Yvw8
         krJwmwB98JLHoEThMSe63eL3A/agTXPpkyMhJdlwI8oJx8212Zj6Di58OQzQkigTPg
         OEzO8JuKsnQ9qYTxpjJMdghhdYE20URnIfHoV/YrSKcSmAT8vCdJPHy45hCrQQRnnj
         y7dLn6m1oWuJQ==
Date:   Wed, 17 Nov 2021 15:43:17 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Lukas Wunner <lukas@wunner.de>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        "Bao, Joseph" <joseph.bao@intel.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Stuart Hayes <stuart.w.hayes@gmail.com>,
        "kw@linux.com" <kw@linux.com>
Subject: Re: HW power fault defect cause system hang on kernel 5.4.y
Message-ID: <20211117214317.GA1777393@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211117080035.GA18186@wunner.de>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Nov 17, 2021 at 09:00:35AM +0100, Lukas Wunner wrote:
> On Tue, Nov 16, 2021 at 02:42:20AM +0000, Bao, Joseph wrote:
> > I've tested this tentative patch, and it fixes the issue.
> 
> Bjorn, do you want me to resend the fix as a proper patch
> (instead of appended to an e-mail) for visibility?

Yes, please; I think it only made it into patchwork as a reply in the
email thread, not as the primary patch, so it'll be less likely to get
lost if you post it as a regular patch.

> If so, do you have any change requests that I should fold in?
> 
> Link to the fix:
> https://lore.kernel.org/linux-pci/20211115192723.GA19161@wunner.de/
> 
> Thanks,
> 
> Lukas
