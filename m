Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F30043F9261
	for <lists+linux-pci@lfdr.de>; Fri, 27 Aug 2021 04:39:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243033AbhH0CkN (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 26 Aug 2021 22:40:13 -0400
Received: from out1.migadu.com ([91.121.223.63]:49005 "EHLO out1.migadu.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233556AbhH0CkN (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 26 Aug 2021 22:40:13 -0400
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1630031963;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=cjmEmg6cpIJ91TusMZj8RMe8MiPkJJ/XPTVR7nIuQXc=;
        b=FEG3a7rlv9ydh/zXYd+Jp5uiExw6VBBKUNoIn1doDGX+YzrNQhZbJEiNxY74lanvF5w+A4
        CivOHPTefNPxhDh2013lghgE8m/4Lzr80nNExfU6SzOFQnX1Z2aLyNVrBpVqc86TIxDy5J
        npKSx4tntrGIS4nF80m+0OGA9MTDyOU=
Date:   Fri, 27 Aug 2021 02:39:23 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   yajun.deng@linux.dev
Message-ID: <d6cbd8d362ae84dde2ccde6698be0d3c@linux.dev>
Subject: Re: [PATCH linux-next] PCI: Fix the order in unregister path
To:     "Rob Herring" <robh@kernel.org>
Cc:     "Bjorn Helgaas" <bhelgaas@google.com>,
        "Arnd Bergmann" <arnd@arndb.de>,
        "Lorenzo Pieralisi" <lorenzo.pieralisi@arm.com>,
        "PCI" <linux-pci@vger.kernel.org>, linux-kernel@vger.kernel.org
In-Reply-To: <CAL_Jsq+rRFJUO3SVLdkQV62dQPymPigiikM05Xipgfbvg_oeqw@mail.gmail.com>
References: <CAL_Jsq+rRFJUO3SVLdkQV62dQPymPigiikM05Xipgfbvg_oeqw@mail.gmail.com>
 <20210825083425.32740-1-yajun.deng@linux.dev>
 <CAL_JsqJ4731w_0rYCSBC_Mma-rn4nUUbKnSwhymGZyh8E7xoWg@mail.gmail.com>
 <63e1e9ea1e4b74b56aeafcc6695ecfa8@linux.dev>
X-Migadu-Flow: FLOW_OUT
X-Migadu-Auth-User: yajun.deng@linux.dev
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

August 26, 2021 8:01 PM, "Rob Herring" <robh@kernel.org> wrote:=0A=0A> On=
 Wed, Aug 25, 2021 at 10:57 PM <yajun.deng@linux.dev> wrote:=0A> =0A>> Au=
gust 25, 2021 9:55 PM, "Rob Herring" <robh@kernel.org> wrote:=0A>> =0A>> =
On Wed, Aug 25, 2021 at 3:34 AM Yajun Deng <yajun.deng@linux.dev> wrote:=
=0A>> =0A>> device_del() should be called first and then called put_devic=
e() in=0A>> unregister path, becase if that the final reference count, th=
e device=0A>> will be cleaned up via device_release() above. So use devic=
e_unregister()=0A>> instead.=0A>> =0A>> Fixes: 9885440b16b8 (PCI: Fix pci=
_host_bridge struct device release/free handling)=0A>> Signed-off-by: Yaj=
un Deng <yajun.deng@linux.dev>=0A>> ---=0A>> drivers/pci/probe.c | 4 +---=
=0A>> 1 file changed, 1 insertion(+), 3 deletions(-)=0A>> =0A>> NAK.=0A>>=
 =0A>> The current code is correct. Go read the comments for device_add/d=
evice_del.=0A>> =0A>> But the device_unregister() is only contains device=
_del() and put_device(). It just put=0A>> device_del() before put_device(=
).=0A> =0A> And that is the wrong order as we want to undo what the code =
above=0A> did. The put_device here is for the get_device we did. The put_=
device=0A> in device_unregister is for the get_device that device_registe=
r did=0A> (on success only).=0A> =0A> Logically, it is wrong too to call =
unregister if register failed. That=0A> would be like doing this:=0A> =0A=
> p =3D malloc(1);=0A> if (!p)=0A> free(p);=0A>=0AThis is the raw code:=
=0A        err =3D device_register(&bus->dev);=0A        if (err)=0A     =
           goto unregister;=0Aunregister:=0A        put_device(&bridge->d=
ev);=0A        device_del(&bridge->dev);=0A=0AThis is my code:=0A        =
err =3D device_register(&bus->dev);=0A        if (err)=0A                =
goto unregister;=0A unregister:=0A        device_unregister(&bridge->dev)=
;=0A=0A=0AThe parameter in  device_register() is bus->dev, but the parame=
ter in device_unregister() is bridge->dev.The are different.=0AThe bridge=
->dev is already success before called device_register().So it wouldn't b=
e happen like your code.=0A=0A =0A> Rob
