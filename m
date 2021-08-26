Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 37F113F8157
	for <lists+linux-pci@lfdr.de>; Thu, 26 Aug 2021 05:57:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232572AbhHZD6a (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 25 Aug 2021 23:58:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229898AbhHZD63 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 25 Aug 2021 23:58:29 -0400
Received: from out2.migadu.com (out2.migadu.com [IPv6:2001:41d0:2:aacc::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5C39C061757;
        Wed, 25 Aug 2021 20:57:42 -0700 (PDT)
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1629950260;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=7SHT0aOimjTS8lAne1TD1ARTfnTJ/YEGCjr9e3NeCjM=;
        b=lkvFotwGnseccRqAR9jDUvsLyk/ZDXKVQakcC8B/K6peBcOzMLJNbfIs+JjK72d68NxuZq
        c2rb+1n24PULFYmp9uuZ6UBeOyX//BXrQrrFqX/kRT4gXCSy9JxxywE3Ar1hixl8RNti6U
        YuLCxoLM+99P2Ur+V1UMGExzxUqzzZk=
Date:   Thu, 26 Aug 2021 03:57:40 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   yajun.deng@linux.dev
Message-ID: <63e1e9ea1e4b74b56aeafcc6695ecfa8@linux.dev>
Subject: Re: [PATCH linux-next] PCI: Fix the order in unregister path
To:     "Rob Herring" <robh@kernel.org>
Cc:     "Bjorn Helgaas" <bhelgaas@google.com>,
        "Arnd Bergmann" <arnd@arndb.de>,
        "Lorenzo Pieralisi" <lorenzo.pieralisi@arm.com>,
        "PCI" <linux-pci@vger.kernel.org>, linux-kernel@vger.kernel.org
In-Reply-To: <CAL_JsqJ4731w_0rYCSBC_Mma-rn4nUUbKnSwhymGZyh8E7xoWg@mail.gmail.com>
References: <CAL_JsqJ4731w_0rYCSBC_Mma-rn4nUUbKnSwhymGZyh8E7xoWg@mail.gmail.com>
 <20210825083425.32740-1-yajun.deng@linux.dev>
X-Migadu-Flow: FLOW_OUT
X-Migadu-Auth-User: yajun.deng@linux.dev
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

August 25, 2021 9:55 PM, "Rob Herring" <robh@kernel.org> wrote:=0A=0A> On=
 Wed, Aug 25, 2021 at 3:34 AM Yajun Deng <yajun.deng@linux.dev> wrote:=0A=
> =0A>> device_del() should be called first and then called put_device() =
in=0A>> unregister path, becase if that the final reference count, the de=
vice=0A>> will be cleaned up via device_release() above. So use device_un=
register()=0A>> instead.=0A>> =0A>> Fixes: 9885440b16b8 (PCI: Fix pci_hos=
t_bridge struct device release/free handling)=0A>> Signed-off-by: Yajun D=
eng <yajun.deng@linux.dev>=0A>> ---=0A>> drivers/pci/probe.c | 4 +---=0A>=
> 1 file changed, 1 insertion(+), 3 deletions(-)=0A> =0A> NAK.=0A> =0A> T=
he current code is correct. Go read the comments for device_add/device_de=
l.=0A=0ABut the device_unregister() is only contains device_del() and put=
_device(). It just put=0Adevice_del() before put_device().=0A=0A> =0A>> d=
iff --git a/drivers/pci/probe.c b/drivers/pci/probe.c=0A>> index 0ec5c792=
c27d..abd481a15a17 100644=0A>> --- a/drivers/pci/probe.c=0A>> +++ b/drive=
rs/pci/probe.c=0A>> @@ -994,9 +994,7 @@ static int pci_register_host_brid=
ge(struct pci_host_bridge *bridge)=0A>> return 0;=0A>> =0A>> unregister:=
=0A> =0A> We get here if device_register() failed. Calling device_unregis=
ter()=0A> in that case is never right.=0A> =0A>> - put_device(&bridge->de=
v);=0A> =0A> This is for the get_device() we do above, not the get the dr=
iver core does.=0A> =0A>> - device_del(&bridge->dev);=0A> =0A> This undoe=
s the device_add() we do following the comment: "NOTE: this=0A> should be=
 called manually _iff_ device_add() was also called=0A> manually."=0A> =
=0A>> -=0A>> + device_unregister(&bridge->dev);=0A>> free:=0A>> kfree(bus=
);=0A>> return err;=0A>> --=0A>> 2.32.0
