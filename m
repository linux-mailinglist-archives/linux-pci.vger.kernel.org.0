Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5867937FB5B
	for <lists+linux-pci@lfdr.de>; Thu, 13 May 2021 18:18:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235084AbhEMQT7 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 13 May 2021 12:19:59 -0400
Received: from mail-0201.mail-europe.com ([51.77.79.158]:42143 "EHLO
        mail-02.mail-europe.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S229521AbhEMQT6 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 13 May 2021 12:19:58 -0400
Date:   Thu, 13 May 2021 16:18:43 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
        s=protonmail; t=1620922726;
        bh=Jrgo0XXerCoyaeKNdMrXxa+mLnN7OrSRZ70vvvyCbj0=;
        h=Date:To:From:Cc:Reply-To:Subject:In-Reply-To:References:From;
        b=cRytavkIgOZ2AbczlB+lzc+Wa0pDdIvCCAAj53zC0FPo6KfJvxz/JteaMsA8jjQFB
         42Xh4T17+vJzNRYPpb7tH+Tmg17si0B+RHLD7NXcPoYxjS7j7elQBXb/BVQEzN79hk
         Gt45X/J+7iqGFBlss6+eQQnngcET8TjWju+zm/5I=
To:     Keith Busch <kbusch@kernel.org>
From:   "linux.enthusiast" <linux.enthusiast@protonmail.com>
Cc:     "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Reply-To: "linux.enthusiast" <linux.enthusiast@protonmail.com>
Subject: Re: How does the "/sys/bus/pci/drivers/*/*" interface work?
Message-ID: <GYS4g2uNcGZCeRW-hNJORKGDsXQAfHgFJ0AdUuap04pphi3FvRHzp09US6FzF4b7HqW1wYMPt8yIIwTWdMRDthHEVMdpQvxtzg8uuNfVS0A=@protonmail.com>
In-Reply-To: <20210513160844.GC2272284@dhcp-10-100-145-180.wdc.com>
References: <bO6tTSRbjFucyxFz_SsgnnkT6H40xY428tQCVi64ig-N6nVg_xxyHzjb7m31oMu0VRSDjMRt9DdH3jMg7sefDSmx-XEyh-Htr3x9o6AU3hk=@protonmail.com> <20210513144650.GA2272206@dhcp-10-100-145-180.wdc.com> <CTXLhLhp53xP5tJrXVibXRGGcF5MG4zpXCnmm_NkF-3GbkH6nC9JpkqLtfeEXfTKV8JJgKsdyaG35rJhMbofPADFCIhdTHWXqC2DEqxdsfU=@protonmail.com> <20210513153523.GA2272284@dhcp-10-100-145-180.wdc.com> <rESCSH2fnmwIxIMl_DQVwjbn5Ib5Iu_TM5kAhRJb6L7Yy4QCbNIrgccFFWIsx1LI-VmcG5SGJQpxscE3LxClwKMbUSj4Qm9ILcj-prLAkNI=@protonmail.com> <20210513160844.GC2272284@dhcp-10-100-145-180.wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.2 required=10.0 tests=ALL_TRUSTED,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM shortcircuit=no
        autolearn=disabled version=3.4.4
X-Spam-Checker-Version: SpamAssassin 3.4.4 (2020-01-24) on
        mailout.protonmail.ch
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thursday, May 13, 2021 6:08 PM, Keith Busch <kbusch@kernel.org> wrote:
> It doesn't look like the kernel provides a way to report a list of
> dynamically assigned ids.

Thanks for all your help Keith Bush, I really appreciate it.

I guess I'll have to always use `new_id` then and if it yells at me try `bi=
nd` instead. Or the other way around.

