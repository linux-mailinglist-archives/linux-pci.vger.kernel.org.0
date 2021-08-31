Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 887913FC0DE
	for <lists+linux-pci@lfdr.de>; Tue, 31 Aug 2021 04:42:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239395AbhHaCmk (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 30 Aug 2021 22:42:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236452AbhHaCmj (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 30 Aug 2021 22:42:39 -0400
Received: from out2.migadu.com (out2.migadu.com [IPv6:2001:41d0:2:aacc::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86BBAC061575;
        Mon, 30 Aug 2021 19:41:45 -0700 (PDT)
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1630377703;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=VCGJByYqb4HN6aatcmB4jj13brXPega5RyBKIfzj7kE=;
        b=nQ8zsSpfJM2alNO1z4AfYZt6AFj744+5h2Uxf+Ku+fWMlWFqfhNo25Pebus2tH8Xpcg6AU
        JlYXEssqrxJYpbwEk8wQgHHOba2fh+olSu0yDWkZ0x3Wpw3Or0H3SfCBXc1l7aLfi7SQT4
        G3vdqrzqP5nE59eqZ1r5Pp36LGJueYU=
Date:   Tue, 31 Aug 2021 02:41:42 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   yajun.deng@linux.dev
Message-ID: <4186a73958319066f76c8a7e2e833b2a@linux.dev>
Subject: Re: [PATCH linux-next] PCI: Fix the order in unregister path
To:     "Rob Herring" <robh@kernel.org>
Cc:     "Bjorn Helgaas" <bhelgaas@google.com>,
        "Arnd Bergmann" <arnd@arndb.de>,
        "Lorenzo Pieralisi" <lorenzo.pieralisi@arm.com>,
        "PCI" <linux-pci@vger.kernel.org>, linux-kernel@vger.kernel.org
In-Reply-To: <CAL_JsqKNOFhfs3=xpsLZRTaNKEnGPTKU58mDJU7AfuAwMdLrmw@mail.gmail.com>
References: <CAL_JsqKNOFhfs3=xpsLZRTaNKEnGPTKU58mDJU7AfuAwMdLrmw@mail.gmail.com>
 <20210825083425.32740-1-yajun.deng@linux.dev>
 <CAL_JsqJ4731w_0rYCSBC_Mma-rn4nUUbKnSwhymGZyh8E7xoWg@mail.gmail.com>
 <63e1e9ea1e4b74b56aeafcc6695ecfa8@linux.dev>
 <CAL_Jsq+rRFJUO3SVLdkQV62dQPymPigiikM05Xipgfbvg_oeqw@mail.gmail.com>
 <d6cbd8d362ae84dde2ccde6698be0d3c@linux.dev>
X-Migadu-Flow: FLOW_OUT
X-Migadu-Auth-User: yajun.deng@linux.dev
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

August 30, 2021 10:55 PM, "Rob Herring" <robh@kernel.org> wrote:=0A=0A> O=
n Thu, Aug 26, 2021 at 9:39 PM <yajun.deng@linux.dev> wrote:=0A> =0A>> Au=
gust 26, 2021 8:01 PM, "Rob Herring" <robh@kernel.org> wrote:=0A>> =0A>> =
On Wed, Aug 25, 2021 at 10:57 PM <yajun.deng@linux.dev> wrote:=0A>> =0A>>=
 August 25, 2021 9:55 PM, "Rob Herring" <robh@kernel.org> wrote:=0A>> =0A=
>> On Wed, Aug 25, 2021 at 3:34 AM Yajun Deng <yajun.deng@linux.dev> wrot=
e:=0A>> =0A>> device_del() should be called first and then called put_dev=
ice() in=0A>> unregister path, becase if that the final reference count, =
the device=0A>> will be cleaned up via device_release() above. So use dev=
ice_unregister()=0A>> instead.=0A>> =0A>> Fixes: 9885440b16b8 (PCI: Fix p=
ci_host_bridge struct device release/free handling)=0A>> Signed-off-by: Y=
ajun Deng <yajun.deng@linux.dev>=0A>> ---=0A>> drivers/pci/probe.c | 4 +-=
--=0A>> 1 file changed, 1 insertion(+), 3 deletions(-)=0A>> =0A>> NAK.=0A=
>> =0A>> The current code is correct. Go read the comments for device_add=
/device_del.=0A>> =0A>> But the device_unregister() is only contains devi=
ce_del() and put_device(). It just put=0A>> device_del() before put_devic=
e().=0A>> =0A>> And that is the wrong order as we want to undo what the c=
ode above=0A>> did. The put_device here is for the get_device we did. The=
 put_device=0A>> in device_unregister is for the get_device that device_r=
egister did=0A>> (on success only).=0A>> =0A>> Logically, it is wrong too=
 to call unregister if register failed. That=0A>> would be like doing thi=
s:=0A> =0A> You are right that the register and unregister are different =
devices.=0A> However, your change is still wrong. The device_register is =
actually=0A> irrelevant.=0A> =0AOK, the original order is right, it was m=
y mistake.=0A=0A>> p =3D malloc(1);=0A>> if (!p)=0A>> free(p);=0A>> =0A>>=
 This is the raw code:=0A>> err =3D device_register(&bus->dev);=0A>> if (=
err)=0A>> goto unregister;=0A>> unregister:=0A>> put_device(&bridge->dev)=
;=0A>> device_del(&bridge->dev);=0A> =0A> The pertinent parts are this:=
=0A> =0A> err =3D device_add(&bridge->dev); // which calls get_device() i=
tself,=0A> so there's the first ref=0A> if (err) {=0A> put_device(&bridge=
->dev);=0A> goto free;=0A> }=0A> bus->bridge =3D get_device(&bridge->dev)=
; // This is the 2nd ref which=0A> the PCI core holds=0A> ...=0A> unregis=
ter:=0A> put_device(&bridge->dev); // This is the put for the get_device=
=0A> just above here.=0A> device_del(&bridge->dev); // Then this does the=
 2nd put.=0A> =0A> The get_device and put_device are paired, and the devi=
ce_add and=0A> device_del are paired.=0A> =0A> As I said earlier, go read=
 the kerneldoc for device_add. For your=0A> convenience, here's the impor=
tant part:=0A> =0A> device_add:=0A> * Rule of thumb is: if device_add() s=
ucceeds, you should call=0A> * device_del() when you want to get rid of i=
t. If device_add() has=0A> * *not* succeeded, use *only* put_device() to =
drop the reference=0A> * count.=0A> =0A> device_del:=0A> * NOTE: this sho=
uld be called manually _iff_ device_add() was=0A> * also called manually.=
=0A> =0A> Rob
