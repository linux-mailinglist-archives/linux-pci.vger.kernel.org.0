Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5EB9D2A2A27
	for <lists+linux-pci@lfdr.de>; Mon,  2 Nov 2020 12:57:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728616AbgKBL5N (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 2 Nov 2020 06:57:13 -0500
Received: from mout.gmx.net ([212.227.17.22]:58425 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728297AbgKBL5N (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 2 Nov 2020 06:57:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1604318207;
        bh=ulH0yL49Zs5eNoVaKp+OGHU1yD5vDappgjihQPEn7Ks=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:References;
        b=WOPzX3clf18xjkG6cpbmvAufRSL4BLR7SHWar27PIxCzjzFD4OAWAbwOBaijiK7aF
         yKvKL+BBepNKKPW0bg8OqzmUlcriOPZlfG6rbW+e26OwOHS7U3laNOv6lvuVS3IiMl
         o3gkhAmcSMH3zLVcENL8ChVdjwx/i/zUndQbOJXA=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [185.76.97.212] ([185.76.97.212]) by web-mail.gmx.net
 (3c-app-gmx-bap57.server.lan [172.19.172.127]) (via HTTP); Mon, 2 Nov 2020
 12:56:47 +0100
MIME-Version: 1.0
Message-ID: <trinity-4313623b-1adf-4cc3-8b50-2d0593669995-1604318207058@3c-app-gmx-bap57>
From:   Frank Wunderlich <frank-w@public-files.de>
To:     Marc Zyngier <maz@kernel.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ryder Lee <ryder.lee@mediatek.com>,
        linux-mediatek@lists.infradead.org,
        Frank Wunderlich <linux@fw-web.de>,
        linux-kernel@vger.kernel.org,
        Matthias Brugger <matthias.bgg@gmail.com>,
        linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>
Subject: Aw: Re:  Re: [PATCH] pci: mediatek: fix warning in msi.h
Content-Type: text/plain; charset=UTF-8
Date:   Mon, 2 Nov 2020 12:56:47 +0100
Importance: normal
Sensitivity: Normal
In-Reply-To: <df5565a2f1e821041c7c531ad52a3344@kernel.org>
References: <20201031140330.83768-1-linux@fw-web.de>
 <878sbm9icl.fsf@nanos.tec.linutronix.de>
 <EC02022C-64CF-4F4B-A0A2-215A0A49E826@public-files.de>
 <87lfflti8q.wl-maz@kernel.org> <1604253261.22363.0.camel@mtkswgap22>
 <trinity-9eb2a213-f877-4af3-87df-f76a9c093073-1604255233122@3c-app-gmx-bap08>
 <87k0v4u4uq.wl-maz@kernel.org> <87pn4w90hm.fsf@nanos.tec.linutronix.de>
 <df5565a2f1e821041c7c531ad52a3344@kernel.org>
X-UI-Message-Type: mail
X-Priority: 3
X-Provags-ID: V03:K1:jYyejVeaj2brOcs4Q4UH22OqS7aiIjBeum4maSh2Zmyo+vBA0JlOayRM2AcnNYk4HcVN6
 p7yRyg/7PGHgiaviKxOOHfQIKOxIFhzucxw8UajnwnTy8ZanOEBLEXJ1b3V7MbnBnH6TmVOwOCV9
 xFUpNVFsnW996VhE7e7jSmHvVKSmVEo9neamw4RFiAWPSA3PB7CR68xGvQR7yoZiw4OeMyA/UYLv
 sLSpUt86s8JSawinnsQBP85qyWaXa2vF0Rr50ofRE7d5u9q9jY1q3GQ20290lUy5FL5mwCoEehs3
 X8=
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:S3IivwM+kT4=:xaI1fXywJdp+SJdYRytlKF
 Vn2q1E3VySGKmOtACNRSqAv7fHe1soTH1bRUgz6FC5P4twwJIDoXh16+fi+p1g22oCpY53E7+
 uzZgDn+b+T8GkGeZhEWUc/Tq4zg1pEQAxbnSuQCAiEKEwnHpT+BlVicNp9gymfp5H+QTwhCKo
 uPa3YmwBuxy7L0rBYmsJhNoLexBsfrDoSVpC38qpej84z351HXtTVt8AV4lFIsGYF9dMjsp4j
 AZUmjocOHKpFMXuxk8rH0bXm6MdZeyEQb43dt58yMVaO2m+eWjsLb2T0bpMU5AlJ1ncH2MpIp
 H9kPQd4afMChDz9YCUWXN47C1lINzhOW5HAc2PSJpnbKHNcMpOyvPFXbA+sNhs1CVCb6bDwkI
 cpFUtwTvXMmoM60df0UXNiDdJZsELiN67qXDgPhYiUmVrKUdS8X3TWv0j8dHyo2MO1FpobXN3
 788r1lzrRT10QDBFK7Q2gdljLqROoofyJkHhIyZ/TKbLDcbZVoVzL3jNHhzuwETBI0hDxZ85R
 kd/Dxt8YpzqL7iJXBYoqWgW21Zk7CU5Q9xJQ6AghZeIUCpRPDaYN0A6pRabqjU2Di1+B524Ll
 F+/t3f787BOeE=
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

looks good on bananapi-r2, no warning, pcie-card and hdd recognized

regards Frank


> diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
> index 4289030b0fff..bb363eb103a2 100644
> --- a/drivers/pci/probe.c
> +++ b/drivers/pci/probe.c
> @@ -871,6 +871,8 @@ static void pci_set_bus_msi_domain(struct pci_bus
> *bus)
>   		d =3D pci_host_bridge_msi_domain(b);
>
>   	dev_set_msi_domain(&bus->dev, d);
> +	if (!d)
> +		bus->bus_flags |=3D PCI_BUS_FLAGS_NO_MSI;
>   }
>
>   static int pci_register_host_bridge(struct pci_host_bridge *bridge)

