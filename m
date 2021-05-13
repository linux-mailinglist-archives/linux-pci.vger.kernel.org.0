Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6C25A37FB1D
	for <lists+linux-pci@lfdr.de>; Thu, 13 May 2021 17:58:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233970AbhEMP7Y (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 13 May 2021 11:59:24 -0400
Received: from mail4.protonmail.ch ([185.70.40.27]:42095 "EHLO
        mail4.protonmail.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234864AbhEMP7U (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 13 May 2021 11:59:20 -0400
X-Greylist: delayed 7687 seconds by postgrey-1.27 at vger.kernel.org; Thu, 13 May 2021 11:59:20 EDT
Date:   Thu, 13 May 2021 15:58:01 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
        s=protonmail; t=1620921488;
        bh=SUp4LbfUXM9DXhnsITqe6PgY3GwHmJIicvxpaAKvH5U=;
        h=Date:To:From:Cc:Reply-To:Subject:In-Reply-To:References:From;
        b=RrJO797Wn7wns61ePTNQ+/EUZ6TI6/ABX19t2+fLYa2qeKyDeTh1sPBjXz7YF/wTL
         6KrQp+bWuGXHbATmWNk0eFaoopGFCd/SAUEdIx0jDMD3Z/ljTfVxJpwHTcFPyp5MnA
         dlXt7B3hyrJ2wzxNmmZnh51V8AgnBa3FLqVBXbuM=
To:     Keith Busch <kbusch@kernel.org>
From:   "linux.enthusiast" <linux.enthusiast@protonmail.com>
Cc:     "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Reply-To: "linux.enthusiast" <linux.enthusiast@protonmail.com>
Subject: Re: How does the "/sys/bus/pci/drivers/*/*" interface work?
Message-ID: <rESCSH2fnmwIxIMl_DQVwjbn5Ib5Iu_TM5kAhRJb6L7Yy4QCbNIrgccFFWIsx1LI-VmcG5SGJQpxscE3LxClwKMbUSj4Qm9ILcj-prLAkNI=@protonmail.com>
In-Reply-To: <20210513153523.GA2272284@dhcp-10-100-145-180.wdc.com>
References: <bO6tTSRbjFucyxFz_SsgnnkT6H40xY428tQCVi64ig-N6nVg_xxyHzjb7m31oMu0VRSDjMRt9DdH3jMg7sefDSmx-XEyh-Htr3x9o6AU3hk=@protonmail.com> <20210513144650.GA2272206@dhcp-10-100-145-180.wdc.com> <CTXLhLhp53xP5tJrXVibXRGGcF5MG4zpXCnmm_NkF-3GbkH6nC9JpkqLtfeEXfTKV8JJgKsdyaG35rJhMbofPADFCIhdTHWXqC2DEqxdsfU=@protonmail.com> <20210513153523.GA2272284@dhcp-10-100-145-180.wdc.com>
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

On Thursday, May 13, 2021 5:35 PM, Keith Busch <kbusch@kernel.org> wrote:
> Run 'modinfo <name-of-driver>'. For pci drivers, each "alias" line will
> show some kind of pci information that the driver binds to.

Thank you, unfortunately there are no `alias` entries or any other entries =
that contain the ID that I dynamically added for the driver I'm looking at =
(vfio-pci). Maybe this approach only works for the IDs the driver has by de=
fault, not the ones added dynamically via `new_id`?

Only for other drivers like `amdgpu` that have default IDs, I can see the a=
liases.
