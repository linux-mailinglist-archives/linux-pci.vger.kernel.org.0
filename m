Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B04F04AE75F
	for <lists+linux-pci@lfdr.de>; Wed,  9 Feb 2022 04:03:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242482AbiBIDCP (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 8 Feb 2022 22:02:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346557AbiBICtJ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 8 Feb 2022 21:49:09 -0500
Received: from sender4-pp-o95.zoho.com (sender4-pp-o95.zoho.com [136.143.188.95])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0581EC014CE1;
        Tue,  8 Feb 2022 18:42:37 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1644374543; cv=none; 
        d=zohomail.com; s=zohoarc; 
        b=IiWquf9atqldWhMR+8jZuNoczLaO3Z/HOKg50E3oFHHYaAzJsmHZ061VXWr/9pZDSB3r6O604qV+YKpzjXg+ekzm3MyjuWzB7dFWIwKqZNx0UpIwvlQ4P14HQXnNuSQqk3jEwiLiih1w2DuoPmDA+3eLRz/K4Gaq9+ix1XQPCYY=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
        t=1644374543; h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:To; 
        bh=Ik7PPsB3ckVMi8MLto9X5w+tlhq8q4mTvX1f+h1UyKw=; 
        b=INVpAAfxFfKWqCwm93kinD9soyLpClf/xM8mZRD/b1w22UkTPLmPrAY5QUoVJ4YKrMkL27nw5mre8eP9HqfUZX2TQo0HOUcOohW4lkgw4mPv83IpymvOn6Q+z5f5WYWZ9wVgHbyLUdJG+0tRGXPiNCj2HNnY1kF5Ma8rVSLxz5w=
ARC-Authentication-Results: i=1; mx.zohomail.com;
        dkim=pass  header.i=zohomail.com;
        spf=pass  smtp.mailfrom=lchen.firstlove@zohomail.com;
        dmarc=pass header.from=<lchen.firstlove@zohomail.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1644374543;
        s=zm2020; d=zohomail.com; i=lchen.firstlove@zohomail.com;
        h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding;
        bh=Ik7PPsB3ckVMi8MLto9X5w+tlhq8q4mTvX1f+h1UyKw=;
        b=axlkY8vZH/QnVnV2YoTmxfCuXYu6R1ZdoeT+iiHxVdFBgcZQju/awJQpwnCmDhpE
        ZkEKT8EbA1QzcZzvF3ecZVMPBL0xHWu9f2myBz1GXTnqv+7Wry5CGlEK6EegJKqg/k4
        k7WhqrZcWx72ch32nP1XVZ67b3MaQyIpARIeTHiE=
Received: from mail.zoho.com by mx.zohomail.com
        with SMTP id 1644374542337509.18593299214297; Tue, 8 Feb 2022 18:42:22 -0800 (PST)
Received: from  [40.115.208.189] by mail.zoho.com
        with HTTP;Tue, 8 Feb 2022 18:42:22 -0800 (PST)
Date:   Tue, 08 Feb 2022 21:42:22 -0500
From:   Li Chen <lchen.firstlove@zohomail.com>
To:     "Bjorn Helgaas" <helgaas@kernel.org>
Cc:     "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
        "Kishon Vijay Abraham I" <kishon@ti.com>,
        "Lorenzo Pieralisi" <lorenzo.pieralisi@arm.com>,
        =?UTF-8?Q?=22Krzysztof_Wilczy=C5=84ski=22?= <kw@linux.com>,
        "Arnd Bergmann" <arnd@arndb.de>,
        "Bjorn Helgaas" <bhelgaas@google.com>,
        "linux-pci" <linux-pci@vger.kernel.org>,
        "linux-kernel" <linux-kernel@vger.kernel.org>
Message-ID: <17edc5c47e6.122924bd015524.7108685407921243810@zohomail.com>
In-Reply-To: <20220208152106.GA476995@bhelgaas>
References: <20220208152106.GA476995@bhelgaas>
Subject: Re: [PATCH V6] misc: pci_endpoint_test: simplify endpoint test read
 and write operations
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Importance: Medium
User-Agent: Zoho Mail
X-Mailer: Zoho Mail
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Sent using Zoho Mail

 ---- On Tue, 08 Feb 2022 10:21:06 -0500 Bjorn Helgaas <helgaas@kernel.org> wrote ----
 > On Mon, Feb 07, 2022 at 11:20:15PM -0500, Li Chen wrote:
 > >  ---- On Mon, 07 Feb 2022 12:56:13 -0500 Bjorn Helgaas <helgaas@kernel.org> wrote ----
 > >  > On Mon, Feb 07, 2022 at 04:09:05AM -0500, Li Chen wrote:
 > >  > > #define to_endpoint_test(priv) container_of((priv), struct pci_endpoint_test, \
 > >  > > -                     miscdev)
 > >  > > +                        miscdev)
 > >  > 
 > >  > Always indent with tabs when possible:
 > >  > 
 > >  >   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/process/coding-style.rst?id=v5.16#n18
 > >  > 
 > >  > Hmm, coding-style.rst is unfortunately not very explicit about that.
 > >  > 
 > >  > But it's obvious from the existing code in this file that things
 > >  > should not be indented four spaces, as you did in
 > >  > pci_endpoint_test_transfer_data().
 > > 
 > > So, can I say space is not allowed in indentation? If so, I should
 > > not use emacs's tabify, because it will not convert 4 space to
 > > 8-width tab. I'm also not sure is scripts/Lindent or clang-format is
 > > a good choice here, they do too much changes.
 > 
 > I don't know how emacs, Lindent, clang-format, etc work.  I *can* tell
 > you that in Linux code:
 > 
 >   - indents always use tabs (width 8) when possible,
 > 
 >   - up to 7 spaces are allowed after a tab when needed to align
 >     something with the previous line, and
 > 
 >   - a tab never directly follows a space.
 > 
 > Bjorn
 > 

Thanks! I'll remove tabify operation in v7, the original code have no indentation code style issue.

Regards,
Li
