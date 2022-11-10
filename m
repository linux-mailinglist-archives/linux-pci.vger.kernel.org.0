Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B188624E2A
	for <lists+linux-pci@lfdr.de>; Fri, 11 Nov 2022 00:01:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229567AbiKJXBO (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 10 Nov 2022 18:01:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231586AbiKJXBM (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 10 Nov 2022 18:01:12 -0500
Received: from out4-smtp.messagingengine.com (out4-smtp.messagingengine.com [66.111.4.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 824815F84B;
        Thu, 10 Nov 2022 15:01:09 -0800 (PST)
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.nyi.internal (Postfix) with ESMTP id 437505C00DF;
        Thu, 10 Nov 2022 18:01:06 -0500 (EST)
Received: from imap44 ([10.202.2.94])
  by compute4.internal (MEProxy); Thu, 10 Nov 2022 18:01:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=flygoat.com; h=
        cc:cc:content-transfer-encoding:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm2; t=1668121266; x=
        1668207666; bh=UKPaSMTeXe77X1VLSlbMaY688QZMhA56dV06akS0nEI=; b=J
        QmGNoucBS4EB9kN1WZiOV7WjS0oh/yBxWSi9iqh994VShw8N7ccdEXdTiqyo7Ayc
        CpT7Jytu36EnWUzHAVq/0cWU5emG3BrixWCr1y6K+HHPQKccGUXbVtMFcrgaQfVe
        m0oA/ZoMfA/OoJ78ZKrNAA7GKPOwoweI6uCYMX5InRsSH/JGeAQiu1NBOVdHdXH7
        4lPeBE2mX1wMj2wcA0PkU8MVoncVihIlkkCAVeQeaIibFZPLNC8TddHVJ6tBYWf4
        0j8xCqSwA0lG1ARbs1qu//izLhkojqJzWSh58lJR/S8kFTxqsUZq6ERE8l6smWCf
        Vt/A5cfPrBFX4V8z47klg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:date:date:feedback-id:feedback-id:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1668121266; x=
        1668207666; bh=UKPaSMTeXe77X1VLSlbMaY688QZMhA56dV06akS0nEI=; b=g
        9HuPmYcvJBDaMQqo9ub73ZT03x7r/WTOghZDdbV5QA01MHFSGn/YeAZLou2LD8JF
        42oGLlB8bSFatcYyHEGAZNCCkBIVNTQGyjhOf67JMPxUpkN/JzMKj2DWRferuziS
        DPy2tDkpNk1qBfbO+G76CJdWvZJ4grw2peXo0x6WT878Iak1FLB9YMa07J9g3J6O
        qS0EryYbTUpx0M985RPPHyVIofwSRhzYpfB+FVX56pbd+EBdBcpJrIYsM1Y3Bj8D
        xX3F/gBEEkZP28dgQQQCcefVJ+FGsANlPqqPz7QldEk7JimVp9SZ9WKQ/Q02Pdt7
        /9qtbBmbF0uc0+XRxeGNQ==
X-ME-Sender: <xms:sYJtYw67NnirCw5ZQZ6pB4WNmATTJyUdmpBKFXUJqvR3ar1qvPByHA>
    <xme:sYJtYx5VOjgif9j-MilEmL0KPuk-m1DkK_PHsnvsmvJvlTiLGfs3_e5Mj7B4gzvTU
    AAq_8xfo2XAa9V44T4>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvgedrfeehgddthecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefofgggkfgjfhffhffvvefutgfgsehtqhertderreejnecuhfhrohhmpedflfhi
    rgiguhhnucgjrghnghdfuceojhhirgiguhhnrdihrghnghesfhhlhihgohgrthdrtghomh
    eqnecuggftrfgrthhtvghrnhepudefgeeftedugeehffdtheefgfevffelfefghefhjeeu
    geevtefhudduvdeihefgnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrg
    hilhhfrhhomhepjhhirgiguhhnrdihrghnghesfhhlhihgohgrthdrtghomh
X-ME-Proxy: <xmx:sYJtY_eJV8yQp4hujJ8GeLKDX8nY4JG9P8NJtZ7W0QlaZTxv7j40og>
    <xmx:sYJtY1IU0U2fuhISevuS_Owgm3YiBvavx2siXIjsGSWfLk0nDlZ1kg>
    <xmx:sYJtY0IXIw5AT9qcpIjUKxwENRXi3EKhHlZ_cOIzmhCcRIHC-NEQ6g>
    <xmx:soJtYxD-Zbec17pVMeIH7h0btg_89z2EjZWFp6piz4am3OwTy0bi8g>
Feedback-ID: ifd894703:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 7725A36A0073; Thu, 10 Nov 2022 18:01:05 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.7.0-alpha0-1115-g8b801eadce-fm-20221102.001-g8b801ead
Mime-Version: 1.0
Message-Id: <e2323333-522c-4127-aaf0-90539fbd0cf4@app.fastmail.com>
In-Reply-To: <20221110210731.GA672063@bhelgaas>
References: <20221110210731.GA672063@bhelgaas>
Date:   Thu, 10 Nov 2022 23:00:45 +0000
From:   "Jiaxun Yang" <jiaxun.yang@flygoat.com>
To:     "Bjorn Helgaas" <helgaas@kernel.org>,
        "Liu Peibao" <liupeibao@loongson.cn>
Cc:     "Bjorn Helgaas" <bhelgaas@google.com>,
        "Rob Herring" <robh+dt@kernel.org>,
        "Krzysztof Kozlowski" <krzysztof.kozlowski+dt@linaro.org>,
        "Lorenzo Pieralisi" <lpieralisi@kernel.org>,
        =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>,
        "Christophe JAILLET" <christophe.jaillet@wanadoo.fr>,
        "Huacai Chen" <chenhuacai@loongson.cn>,
        "Jianmin Lv" <lvjianmin@loongson.cn>,
        "Yinbo Zhu" <zhuyinbo@loongson.cn>,
        linux-pci <linux-pci@vger.kernel.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH V4] PCI: loongson: Skip scanning unavailable child devices
Content-Type: text/plain;charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



=E5=9C=A82022=E5=B9=B411=E6=9C=8810=E6=97=A5=E5=8D=81=E4=B8=80=E6=9C=88 =
=E4=B8=8B=E5=8D=889:07=EF=BC=8CBjorn Helgaas=E5=86=99=E9=81=93=EF=BC=9A
> On Tue, Nov 08, 2022 at 02:42:40PM +0800, Liu Peibao wrote:
>> The PCI Controller of 2k1000 could not mask devices by setting vender=
 ID or
>> device ID in configuration space header as invalid values. When there=
 are
>> pins shareable between the platform device and PCI device, if the pla=
tform
>> device is preferred, we should not scan this PCI device. In the above
>> scene, add `status =3D "disabled"` property in DT node of this PCI de=
vice.
>>=20
>> Signed-off-by: Liu Peibao <liupeibao@loongson.cn>
>> ---
>> V3 -> V4: 1. get rid of the masklist and search the status property
>> 	  directly.
>>           2. check the status property only when accessing the vendor=
 ID.
>> V2 -> V3: 1. use list_for_each_entry() for more clearly.
>>           2. fix wrong use of sizeof().
>> V1 -> V2: use existing property "status" instead of adding new proper=
ty.
>>=20
>>  drivers/pci/controller/pci-loongson.c | 11 +++++++++++
>>  1 file changed, 11 insertions(+)
>>=20
>> diff --git a/drivers/pci/controller/pci-loongson.c b/drivers/pci/cont=
roller/pci-loongson.c
>> index 05c50408f13b..efca0b3b5a29 100644
>> --- a/drivers/pci/controller/pci-loongson.c
>> +++ b/drivers/pci/controller/pci-loongson.c
>> @@ -194,6 +194,17 @@ static void __iomem *pci_loongson_map_bus(struct=
 pci_bus *bus,
>>  			return NULL;
>>  	}
>> =20
>> +#ifdef CONFIG_OF
>> +	/* Don't access disabled devices. */
>> +	if (pci_is_root_bus(bus) && where =3D=3D PCI_VENDOR_ID) {
>> +		struct device_node *dn;
>> +
>> +		dn =3D of_pci_find_child_device(bus->dev.of_node, devfn);
>> +		if (dn && !of_device_is_available(dn))
>> +			return NULL;
>> +	}
>> +#endif
>
> Looks nice and simple, thanks for trying this out.

Should we make this into common PCI code?
I guess Loongson won=E2=80=99t be the last platform having such problem.


>
>>  	/* CFG0 can only access standard space */
>>  	if (where < PCI_CFG_SPACE_SIZE && priv->cfg0_base)
>>  		return cfg0_map(priv, bus, devfn, where);
>> --=20
>> 2.20.1
>>

--=20
- Jiaxun
