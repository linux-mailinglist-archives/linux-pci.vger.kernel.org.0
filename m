Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 749E07DF11E
	for <lists+linux-pci@lfdr.de>; Thu,  2 Nov 2023 12:27:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347345AbjKBL13 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 2 Nov 2023 07:27:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347243AbjKBL12 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 2 Nov 2023 07:27:28 -0400
Received: from wout5-smtp.messagingengine.com (wout5-smtp.messagingengine.com [64.147.123.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54820111;
        Thu,  2 Nov 2023 04:27:22 -0700 (PDT)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.west.internal (Postfix) with ESMTP id 80C2C3200999;
        Thu,  2 Nov 2023 07:27:18 -0400 (EDT)
Received: from imap44 ([10.202.2.94])
  by compute3.internal (MEProxy); Thu, 02 Nov 2023 07:27:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=flygoat.com; h=
        cc:cc:content-transfer-encoding:content-type:content-type:date
        :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to; s=fm1; t=
        1698924438; x=1699010838; bh=qnoBr0axhGTzmrMpnTUgIJi6AVoVM2Yv3UZ
        5FiYaoBU=; b=sc764kvD/TTRiG6jBZxCEn7xXI0z5dHbpj5UYBPJCQxCtNqYkCf
        n7mXa1dYgEgwz1/CF//ljQAjamdDozYwFZjirioah2KLBumPM86oTH4jEKGaIKxf
        /tC85yQuiKxK8llZ0U5tyLcmi2B6BKqZ4sCfgkO8KkBZE905BhThVAFpyb/IiGQr
        mvHI3Yzxop2oj4yvK5xb7XptDfohzZlNAG/43OmH6//b2fKeU4Nr+17rJpT2bW5u
        R5PLrTVJQPh7PpoczKN8hA/kyYW1FVyNyOcEBXQRsxx+kmqK4Xz9mQpjKF/85qRl
        dxgzC+ujHhx7p57yfZC6LkvILu/qY0BMxCg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:content-type:date:date:feedback-id:feedback-id
        :from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
        1698924438; x=1699010838; bh=qnoBr0axhGTzmrMpnTUgIJi6AVoVM2Yv3UZ
        5FiYaoBU=; b=IUOkmwwg/DLe+ETpwWVKLlG/c/BFwE33eVNFfKLLISIh+BaDva5
        2vELNrYCayd/v5zecQQ2ve3edSO2gE+ExkfJXm8zRu4wY21e0E62Em8zQXq3X1WB
        /FFKV8F7xEddXdVLVSiMJMNGeYe3uQjcNuJkVIzj5qOgRc1dYkyiaHxfSeKjVzn6
        nB1ygA7UGUfp+lYDpYq8wJoUEgusLPhFPN8v4IYDfPOcfN/zFS2HqgMOgHjTXyXy
        MnoVeu30CA7TmvNVbqVISaqvxsaHgBKmcROS5zERrvY9o9JgyaJTvqNPsMeDzJMT
        5/qqelOahhmbuLt2xxGTjetOAQnEeg4SnFQ==
X-ME-Sender: <xms:lYdDZSnUEW4E2HjhRnB2rPm7grhFd0YBKrsrBfqhIUESBoG0QAQAZg>
    <xme:lYdDZZ1H9k0ge8fYCY_ZDaZ5_rZjNTQ3-gqIERLWnHQ8MQ8JZr0zGsALur46RmROZ
    utLKQiLnw5nkjQ1XGs>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedruddtiedgvdekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtgfesthhqredtreerjeenucfhrhhomhepfdfl
    ihgrgihunhcujggrnhhgfdcuoehjihgrgihunhdrhigrnhhgsehflhihghhorghtrdgtoh
    hmqeenucggtffrrghtthgvrhhnpeekleevffehtdeigfekfefhffdtudffvdeuvedtffet
    heeuiefhgfetleekleekjeenucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecuvehluh
    hsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepjhhirgiguhhnrdih
    rghnghesfhhlhihgohgrthdrtghomh
X-ME-Proxy: <xmx:lYdDZQrkT5juP-tsw7PaxVbI8WnpY-H0LoPL50OIau3J53pTaq5gGw>
    <xmx:lYdDZWmAAMuQqLI33hlKVtFD1k8EBTmzeFZwiBpAYx4Wfgm8rDkvyA>
    <xmx:lYdDZQ3HpI219ZwqLMeOKlw5eSUXXsvy3ruc5HnR165jsl9oeVI_dw>
    <xmx:lodDZU9V_UtuuB6Vw94hyVjtlGinTiIQUroLNUfLgp-lW5UYxJ5i6Q>
Feedback-ID: ifd894703:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 6B4AE36A0075; Thu,  2 Nov 2023 07:27:17 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-1108-g3a29173c6d-fm-20231031.005-g3a29173c
MIME-Version: 1.0
Message-Id: <a49a86b1-c938-4f00-8fb8-311f7a9ee31c@app.fastmail.com>
In-Reply-To: <20231101220222.GA99154@bhelgaas>
References: <20231101220222.GA99154@bhelgaas>
Date:   Thu, 02 Nov 2023 11:26:46 +0000
From:   "Jiaxun Yang" <jiaxun.yang@flygoat.com>
To:     "Bjorn Helgaas" <helgaas@kernel.org>
Cc:     linux-pci <linux-pci@vger.kernel.org>,
        "Lorenzo Pieralisi" <lpieralisi@kernel.org>,
        =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>,
        "Rob Herring" <robh@kernel.org>, linux-kernel@vger.kernel.org,
        "Huacai Chen" <chenhuacai@kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: Re: [PATCH fixes v4] pci: loongson: Workaround MIPS firmware MRRS settings
Content-Type: text/plain;charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



=E5=9C=A82023=E5=B9=B411=E6=9C=881=E6=97=A5=E5=8D=81=E4=B8=80=E6=9C=88 =E4=
=B8=8B=E5=8D=8810:02=EF=BC=8CBjorn Helgaas=E5=86=99=E9=81=93=EF=BC=9A
> On Wed, Nov 01, 2023 at 11:49:56AM +0000, Jiaxun Yang wrote:
>> This is a partial revert of commit 8b3517f88ff2 ("PCI:
>> loongson: Prevent LS7A MRRS increases") for MIPS based Loongson.
>
> Thanks for this patch.  We're in the v6.7 merge window, so we won't
> start merging v6.8 content until v6.7-rc1 (probably Nov 12).
>
>> There are many MIPS based Loongson systems in wild that
>> shipped with firmware which does not set maximum MRRS properly.
>
> As far as I know, there's no requirement for firmware to set MRRS at
> all *except* for the "no_inc_mrrs" hack added by 8b3517f88ff2.  That
> hack treats the current MRRS value as a limit to work around the
> Loongson bug that read requests larger than the limit cause a
> Completer Abort instead of multiple completions.

Yep, it happens that we can't trust MRRS left by firmware on MIPS
Loongson.
>
>> Limiting MRRS to 256 for all as MIPS Loongson comes with higher
>> MRRS support is considered rare.
>>=20
>> It must be done at device enablement stage because hardware will
>> reset MRRS to inavlid value if a device got disabled.
>
> s/inavlid/invalid/
>
> This part isn't clear to me, though.  What exactly does "device got
> disabled" mean?  The device got reset?  Power cycled?
> PCI_COMMAND_MASTER was cleared?
>
> PCI_FIXUP_ENABLE quirks are run during pci_enable_device(), which
> basically just turns on PCI_COMMAND_MEMORY and/or PCI_COMMAND_IO.
>
> If MRRS gets reset when PCI_COMMAND_MASTER is set or cleared, we don't
> have a quirk phase that runs during pci_set_master(), which is where
> PCI_COMMAND_MASTER gets set, so it's not clear that
> pci_enable_device() is the right place.

I should make myself clear that MRRS reset actually happens when the
PCIe port (i.e. the PCI to PCI bridge) lose it's PCI_COMMAND_MASTER.

Since pci_enable_bridge is called by pci_enable_device it is still the
best place for such quirk.

I'll amend the commit message to make it clear.

>
>> Cc: stable@vger.kernel.org
>> Closes: https://bugzilla.kernel.org/show_bug.cgi?id=3D217680
>> Fixes: 8b3517f88ff2 ("PCI: loongson: Prevent LS7A MRRS increases")
>> Signed-off-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
>
> We'll look for an ack from the maintainer.  Maybe that's you, since
> you added the driver in the first place?  Or maybe it's Huacai?

I'm dumb to ACPI enabled Loongson so I think Huacai must be the maintain=
er
but I'd like to take care of this driver as well, perhaps having two M e=
ntry
or give me an R entry?

Huacai, what's your opinion?

>
> MAINTAINERS currently doesn't list anybody for
> drivers/pci/controller/pci-loongson.c, and it should.  That should be
> a separate patch.
>
>> ---
>> v4: Improve commit message
>>=20
>> This is a partial revert of the origin quirk so there shouldn't
>> be any drama.
>> ---
>>  drivers/pci/controller/pci-loongson.c | 38 +++++++++++++++++++++++++=
++
>>  1 file changed, 38 insertions(+)
>>=20
>> diff --git a/drivers/pci/controller/pci-loongson.c b/drivers/pci/cont=
roller/pci-loongson.c
>> index d45e7b8dc530..d184d7b97e54 100644
>> --- a/drivers/pci/controller/pci-loongson.c
>> +++ b/drivers/pci/controller/pci-loongson.c
>> @@ -108,6 +108,44 @@ DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_LOONGSON,
>>  DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_LOONGSON,
>>  			DEV_LS7A_PCIE_PORT6, loongson_mrrs_quirk);
>> =20
>> +#ifdef CONFIG_MIPS
>> +static void loongson_old_mrrs_quirk(struct pci_dev *pdev)
>> +{
>> +	struct pci_bus *bus =3D pdev->bus;
>> +	struct pci_dev *bridge;
>> +	static const struct pci_device_id bridge_devids[] =3D {
>> +		{ PCI_VDEVICE(LOONGSON, DEV_LS2K_PCIE_PORT0) },
>> +		{ PCI_VDEVICE(LOONGSON, DEV_LS7A_PCIE_PORT0) },
>> +		{ PCI_VDEVICE(LOONGSON, DEV_LS7A_PCIE_PORT1) },
>> +		{ PCI_VDEVICE(LOONGSON, DEV_LS7A_PCIE_PORT2) },
>> +		{ PCI_VDEVICE(LOONGSON, DEV_LS7A_PCIE_PORT3) },
>> +		{ PCI_VDEVICE(LOONGSON, DEV_LS7A_PCIE_PORT4) },
>> +		{ PCI_VDEVICE(LOONGSON, DEV_LS7A_PCIE_PORT5) },
>> +		{ PCI_VDEVICE(LOONGSON, DEV_LS7A_PCIE_PORT6) },
>
> This looks like the same list of devices as for loongson_mrrs_quirk().
> So I guess the idea is that we need loongson_mrrs_quirk() for
> Loongarch-based systems, and this loongson_old_mrrs_quirk() for
> MIPS-based systems?
>
> If so, maybe they could be #ifdef'd to show that, e.g., so that only
> one or the other is compiled?

I think no_inc_mrrs still needs to be set for those devices so I left
the "new" quirk enabled for MIPS as well here.

But we can also do it in "old" quirk with an extra match, will do in next
version.

[...]

--=20
- Jiaxun
