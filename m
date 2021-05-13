Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BF52037FAAB
	for <lists+linux-pci@lfdr.de>; Thu, 13 May 2021 17:26:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234874AbhEMP1R (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 13 May 2021 11:27:17 -0400
Received: from mail-0201.mail-europe.com ([51.77.79.158]:49840 "EHLO
        mail-02.mail-europe.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S234896AbhEMP1N (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 13 May 2021 11:27:13 -0400
Date:   Thu, 13 May 2021 15:25:50 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
        s=protonmail; t=1620919557;
        bh=HKRBfhwEe+1z4dxqtRaYyAss61rE5D/AoNHom45c66w=;
        h=Date:To:From:Cc:Reply-To:Subject:In-Reply-To:References:From;
        b=TdBatGDUPpWzkg6DMzrX1uEZU7i7DMY8jIiAjC5CVJzC/e277iLGYFYZmyBO/ML2H
         RxZNK6+L12PSfD2y1MOqfwZRTDTkDvo0NDbtZwbAfdUeMOPuDfP7HaZ3NeT9zRGzDn
         f2EcNME7NH/nkVKU1nPNja916Ud74jdL2tS46df8=
To:     Keith Busch <kbusch@kernel.org>
From:   "linux.enthusiast" <linux.enthusiast@protonmail.com>
Cc:     "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Reply-To: "linux.enthusiast" <linux.enthusiast@protonmail.com>
Subject: Re: How does the "/sys/bus/pci/drivers/*/*" interface work?
Message-ID: <CTXLhLhp53xP5tJrXVibXRGGcF5MG4zpXCnmm_NkF-3GbkH6nC9JpkqLtfeEXfTKV8JJgKsdyaG35rJhMbofPADFCIhdTHWXqC2DEqxdsfU=@protonmail.com>
In-Reply-To: <20210513144650.GA2272206@dhcp-10-100-145-180.wdc.com>
References: <bO6tTSRbjFucyxFz_SsgnnkT6H40xY428tQCVi64ig-N6nVg_xxyHzjb7m31oMu0VRSDjMRt9DdH3jMg7sefDSmx-XEyh-Htr3x9o6AU3hk=@protonmail.com> <20210513144650.GA2272206@dhcp-10-100-145-180.wdc.com>
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

> Documentation/ABI/testing/sysfs-bus-pci.
Thank you, that was incredibly helpful!

There's just one thing that I couldn't find an answer to and that is how to=
 list the current device IDs of a given PCI device driver.

I mean I understand there are default ones and that I can use `new_id` to a=
dd dynamic ones, but I don't know how to list any of these in order to know=
 if a `new_id` call would even make sense.
