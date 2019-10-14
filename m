Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E11B4D5AEA
	for <lists+linux-pci@lfdr.de>; Mon, 14 Oct 2019 07:55:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726573AbfJNFzB (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 14 Oct 2019 01:55:01 -0400
Received: from mail-ua1-f53.google.com ([209.85.222.53]:36223 "EHLO
        mail-ua1-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726169AbfJNFzB (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 14 Oct 2019 01:55:01 -0400
Received: by mail-ua1-f53.google.com with SMTP id r25so4632682uam.3
        for <linux-pci@vger.kernel.org>; Sun, 13 Oct 2019 22:55:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=RnPm1nvmATxoGrHy+imAyvbNAEXi8Zri9vVJglGWOTM=;
        b=pnoLvZ8WEWc++U1rgZmd5C0fHi5tR1VooVwwlGXiZkcH51D0YaKZDIzoG7zO12v5M3
         GjEcU+nxR3wbcmLnh4EIrYNeksVZWYhiPbkpQ8c4o9zXcNkPR+EQjp5gM5hqztAC7vAd
         nhRHF/9pHEoBuNPg5IUSK1154jTlxExchYn+VdZnvQS1mIHZ6Yt8vSDwP2ZhWnGgNHXr
         KJ8Pw/wu9n8vE3Hpa1xlVo1BDpyPT6uGl9F1LbA2gvmZYGt5OBMOkRG/WKwRLoNQd6UR
         lsBmSMETjCJWjdm6dJjDURXv/PWorLk1zdEKMzh5y2w913GqNe7j3H33YcVMF31Cb/Z1
         BnYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=RnPm1nvmATxoGrHy+imAyvbNAEXi8Zri9vVJglGWOTM=;
        b=J2xP2P9g9gWlagfHYthZZj7kb4WnKQgzvKNw4VtRlZSDD436C8qoNz3u29qEkjEWZP
         7ye/nL+Gu2eFqK6CU5zXBcvvml6OhmDKkdbkvAQUnlnp9M3T3N71QkI/4U8IyZFEjCcN
         2nxgSGv0+XWmS4/y6BT0nwV3V7jAX22DcJnF3vePqqQf+GjSWpGnnwE9mCIm/zKNIUDx
         HBid7OOm+s8nayCfvoLw0Jbo15H1sqoWBAoLnL7c1hTJ7O9xI95ZRsglCXs+KafXHAvi
         X20wzzEmfrrzbZegeI1DxD7xR3gaIopSEZl1jBfvzwfS51EoN6ZESUVBUcj0h9/nQRMJ
         JEHA==
X-Gm-Message-State: APjAAAVR4ozzz2+rHMYWifE6Jrh5YXGiNLZ7LfhK/L/FQ54iVmL2MrqM
        3BbhlOMUj6Fsp1gZ1ZUkzoyO7Z5HHn01eQryIPw=
X-Google-Smtp-Source: APXvYqzpi9SeNFGGBft2Wy0D9aohTwrrvHkm3fn0RQj3JXpAWVfBn0ZvRvbFCXEdTZm+UV5Ol8cGmvW21O72EwDcw14=
X-Received: by 2002:ab0:628f:: with SMTP id z15mr11451149uao.126.1571032499698;
 Sun, 13 Oct 2019 22:54:59 -0700 (PDT)
MIME-Version: 1.0
References: <20191008164232.GA173643@google.com> <20191009040534.GL2819@lahna.fi.intel.com>
 <CAMz9Wg_8ZYkw1f3MyqcqNMBajJ_Q+qwojQhg8WqiPTPeUSNXZQ@mail.gmail.com>
 <20191009075650.GM2819@lahna.fi.intel.com> <CA+CmpXupMC5Kk_tCX8-TQESM2BQ9RFU196dzXGmpv9TcMgyb4A@mail.gmail.com>
In-Reply-To: <CA+CmpXupMC5Kk_tCX8-TQESM2BQ9RFU196dzXGmpv9TcMgyb4A@mail.gmail.com>
From:   AceLan Kao <acelan@gmail.com>
Date:   Mon, 14 Oct 2019 13:54:48 +0800
Message-ID: <CAMz9Wg_2niJcSs_wOkiVm44zDd8_sVdhhM64MJd-+XTqEmbgMw@mail.gmail.com>
Subject: Re: [bugzilla-daemon@bugzilla.kernel.org: [Bug 205119] New: It takes
 long time to wake up from s2idle on Dell XPS 7390 2-in-1]
To:     Yehezkel Bernat <yehezkelshb@gmail.com>
Cc:     Mika Westerberg <mika.westerberg@linux.intel.com>,
        Bjorn Helgaas <helgaas@kernel.org>,
        Linux PCI <linux-pci@vger.kernel.org>,
        Andreas Noever <andreas.noever@gmail.com>,
        Michael Jamet <michael.jamet@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

After upgrade the BIOS to v1.0.13, the issue is gone.
Thanks.

Yehezkel Bernat <yehezkelshb@gmail.com> =E6=96=BC 2019=E5=B9=B410=E6=9C=881=
0=E6=97=A5 =E9=80=B1=E5=9B=9B =E4=B8=8B=E5=8D=884:09=E5=AF=AB=E9=81=93=EF=
=BC=9A
>
> On Wed, Oct 9, 2019 at 10:56 AM Mika Westerberg
> <mika.westerberg@linux.intel.com> wrote:
> >
> > On Wed, Oct 09, 2019 at 03:50:25PM +0800, AceLan Kao wrote:
> >
> > > There is a new BIOS v1.0.13 on dell website, but it requires windows
> > > to upgrade it, I'll try it later.
> >
> > OK, thanks.
>
> I'd try to check fwupd if you haven't tried it yet.
> Dell FW is usually available there.



--=20
Chia-Lin Kao(AceLan)
http://blog.acelan.idv.tw/
E-Mail: acelan.kaoATcanonical.com (s/AT/@/)
