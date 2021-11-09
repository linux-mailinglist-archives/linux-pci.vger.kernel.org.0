Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DFB6444B05A
	for <lists+linux-pci@lfdr.de>; Tue,  9 Nov 2021 16:29:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231252AbhKIPcj (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 9 Nov 2021 10:32:39 -0500
Received: from mail.kernel.org ([198.145.29.99]:39368 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236677AbhKIPcj (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 9 Nov 2021 10:32:39 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id B23DE611CA;
        Tue,  9 Nov 2021 15:29:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1636471793;
        bh=eJtozRUR5h8pluy5NEdrhAqmDhEU6q84/t9GV3y8+1o=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=a7zUzYaPODFM1y4fYyQAX3RlfgrpmzTGX192L/0wnwqk9aB6vyh2QymVPvfHDdHPL
         jFeDvjcuV4qTmreOw3AFSF+KfJ9TtPoRgRI4Mro/O+9z1Ja79lEDwlw5Axk0Sspmde
         xBnJ9PFm28H6b2u0T8q0SqUA8zexRsdlvKfBRB3BAwfPBxvGbJbNrQutXL9c5QlyDp
         9/DViqZAqJ9Eu7Jy8lOHyq2G9VMV0s/Ra3+S6iT2oTkTvC5kH2H1kYiO5CgzGH8J/W
         tZYYpozOPDVHX/eII/KW06djWDzwQuSfRJnMGBtcSmBJZJI0vEcBmfpkJHK5ssShGq
         CzWyqu1tBec3g==
Date:   Tue, 9 Nov 2021 09:29:51 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     "Bao, Joseph" <joseph.bao@intel.com>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Stuart Hayes <stuart.w.hayes@gmail.com>,
        Lukas Wunner <lukas@wunner.de>
Subject: Re: HW power fault defect cause system hang on kernel 5.4.y
Message-ID: <20211109152951.GA1146992@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DM8PR11MB570219FE94A7983E0F61A3BA86929@DM8PR11MB5702.namprd11.prod.outlook.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Nov 09, 2021 at 07:59:59AM +0000, Bao, Joseph wrote:
> Hi Lukas/Stuart,
> Want to follow up with you whether the system hang is expected when
> HW has a defect keeping PCI_EXP_SLTSTA_PFD always HIGH.

A system hang in response to a hardware defect like this is never the
expected situation.  Worst case we should be able to work around it
with a quirk.  Far better would be a generic fix that could recognize
and deal with the situation even without a quirk.

But I don't know the fix yet.  I'm just responding to encourage you to
keep pestering us and not give up :)  In the meantime, it might be
worth opening a report at https://bugzilla.kernel.org with a
description of how you trigger the problem, and attaching the complete
dmesg log and "sudo lspci -vv" output.

Bjorn
