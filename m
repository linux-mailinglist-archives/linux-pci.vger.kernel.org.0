Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8311D1DB278
	for <lists+linux-pci@lfdr.de>; Wed, 20 May 2020 13:58:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726596AbgETL6A (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 20 May 2020 07:58:00 -0400
Received: from sender3-op-o12.zoho.com.cn ([124.251.121.243]:17788 "EHLO
        sender3-op-o12.zoho.com.cn" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726443AbgETL57 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 20 May 2020 07:57:59 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1589975853; cv=none; 
        d=zoho.com.cn; s=zohoarc; 
        b=p/SNiSfufx29MQuL58cLrWZB6QhUWSM1054M8OlDVbjvIpVIoGz/bOYCAqdDl87ymxhAIgSusDguFD95a6d7mpCKC6ZaadsTmreYe0VP9KTsQ6kd9iyJ638nAqlWqbX8xQMbrrQ7EnFt6CGY5rnjX5AVLanRlu/5cVNPwGP7ZyY=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zoho.com.cn; s=zohoarc; 
        t=1589975853; h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:Reply-To:References:Subject:To; 
        bh=eRM1Z8d5iAv6qyqsY9fzErt/J83QuBOH4Flqxzq3cCg=; 
        b=p4cZkj1HuNqaj0fhypCbsuCqA/lbH7jJf2lqP5LNWplBFn3uQ3ZsBQpiQ5q1oViVvXpL4/8pIEsxO200JHow79CTtW9BqrT3aImn/pJfE1RCOTy8c+q243KHbVALcJy/p5sM5g3KQP8ue3Ni6sCvTI12MUZgXQ5luXFfbREJIbk=
ARC-Authentication-Results: i=1; mx.zoho.com.cn;
        dkim=pass  header.i=flygoat.com;
        spf=pass  smtp.mailfrom=jiaxun.yang@flygoat.com;
        dmarc=pass header.from=<jiaxun.yang@flygoat.com> header.from=<jiaxun.yang@flygoat.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1589975853;
        s=mail; d=flygoat.com; i=jiaxun.yang@flygoat.com;
        h=Date:From:To:CC:Subject:Reply-to:In-Reply-To:References:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding;
        bh=eRM1Z8d5iAv6qyqsY9fzErt/J83QuBOH4Flqxzq3cCg=;
        b=gE41HbZfLHGZVzmcDcEejnCbbZBAvYf8qNld3LrvVQuYRyygOCXa3reB/IaY8vUJ
        tJ7TiyhfBctR0ENTK2RrGJj593EBSF0qHkTuCZBOpUqYS2zxytI910StUb3XL9zEEmn
        sp/JvpuZIkAmmMmxwHgoxmq/vJ61cg19tjcJly/M=
Received: from [127.0.0.1] (223.104.210.187 [223.104.210.187]) by mx.zoho.com.cn
        with SMTPS id 158997585129542.79948251014355; Wed, 20 May 2020 19:57:31 +0800 (CST)
Date:   Wed, 20 May 2020 19:57:29 +0800
From:   Jiaxun Yang <jiaxun.yang@flygoat.com>
To:     linux-pci@vger.kernel.org
CC:     Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
        Rob Herring <robh+dt@kernel.org>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Huacai Chen <chenhc@lemote.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Paul Burton <paulburton@kernel.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mips@vger.kernel.org
Subject: Re: [PATCH v10 2/5] PCI: Add Loongson PCI Controller support
User-Agent: K-9 Mail for Android
Reply-to: jiaxun.yang@flygoat.com
In-Reply-To: <20200514131650.3587281-2-jiaxun.yang@flygoat.com>
References: <20200427060551.1372591-1-jiaxun.yang@flygoat.com> <20200514131650.3587281-1-jiaxun.yang@flygoat.com> <20200514131650.3587281-2-jiaxun.yang@flygoat.com>
Message-ID: <AC29D474-D846-41AF-9900-759CE430A744@flygoat.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-ZohoCNMailClient: External
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



=E4=BA=8E 2020=E5=B9=B45=E6=9C=8814=E6=97=A5 GMT+08:00 =E4=B8=8B=E5=8D=889=
:16:38, Jiaxun Yang <jiaxun=2Eyang@flygoat=2Ecom> =E5=86=99=E5=88=B0:
>This controller can be found on Loongson-2K SoC, Loongson-3
>systems with RS780E/LS7A PCH=2E
>
>The RS780E part of code was previously located at
>arch/mips/pci/ops-loongson3=2Ec and now it can use generic PCI
>driver implementation=2E
>
>Signed-off-by: Jiaxun Yang <jiaxun=2Eyang@flygoat=2Ecom>
>Reviewed-by: Rob Herring <robh@kernel=2Eorg>
>

Hi there,

Is it possible to let this series go into next tree soon?

As LS7A dts patch would depend on this series, and I want to
make the whole LS7A basic support as a part of 5=2E8 release=2E

Thanks!

--=20
Jiaxun Yang
