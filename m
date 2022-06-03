Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1949E53D3BC
	for <lists+linux-pci@lfdr.de>; Sat,  4 Jun 2022 00:59:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231585AbiFCW7E (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 3 Jun 2022 18:59:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244659AbiFCW7D (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 3 Jun 2022 18:59:03 -0400
Received: from wout4-smtp.messagingengine.com (wout4-smtp.messagingengine.com [64.147.123.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE424544C0
        for <linux-pci@vger.kernel.org>; Fri,  3 Jun 2022 15:59:00 -0700 (PDT)
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.west.internal (Postfix) with ESMTP id 3A1F432007E8;
        Fri,  3 Jun 2022 18:58:57 -0400 (EDT)
Received: from imap44 ([10.202.2.94])
  by compute4.internal (MEProxy); Fri, 03 Jun 2022 18:58:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=flygoat.com; h=
        cc:cc:content-transfer-encoding:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm2; t=1654297136; x=
        1654383536; bh=hAEZWB+IAA2azFyu8P8nd0Hwa6PRfuxB0eOMQ39W/E4=; b=e
        /J0C3YSGuWwsI+E267Gj+SKlHtNw4jcnKMn6SKHHxCMUCAntN802pQjIsczFn09e
        3e0WM4XziEbH1KooUk6J+eG6Zbjui3o1MPUxTCB96NKUP31VcsijtWdF8+ECSAwy
        Kx3F84DkSb6elSBaIxNOMxRRel5pQvYdRwvcl0guz78nJQeGAjsNUm1i4qfGzFXQ
        XZ2RGtFO+hVrPzs2YG+SGdLSmJcybYgILy/8WCHNBEW8OOM8w22Un5KlXFOE1nXk
        uF8mqMJ88QVo+16zTUuC9HFhurhtWCbBfLtYTEDYufUgmfc0YDOOLqRQifAgxn4u
        Qvgp2EVSarkz4yzZ23Jpw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:date:date:feedback-id:feedback-id:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1654297136; x=
        1654383536; bh=hAEZWB+IAA2azFyu8P8nd0Hwa6PRfuxB0eOMQ39W/E4=; b=O
        Tkx8oTUAFeWb0ScjM6WxrPQ1zWNQC2UdcCHA4ClJaYGHohFupdN1Wj3AqZrR/Er9
        rW3xmby41o0UJb/lGhe0q9WcXP3NSsc1w34Hi/OScMdkRjMHn645TraVtCLqSC2X
        ijhjWHjENCMKtkGkdgX3/o8L/3z2VHHnlhFOjvT9DhwXztsC2RZkNjzAgHDsoPnK
        JdtLJCz6blWteedHQ2gnXBHeVtqt3aWFgLu/3Dzy8lw3nU1EFwoZW75yg3mR7dgT
        8WbdCWu6pn3A4rSOR3d24hmHN48JZHRwIIZLpds7CwazJn1wgu5KeqLtLXHLdqpp
        wgogQ8EqDWFjQQjisrvjQ==
X-ME-Sender: <xms:L5KaYnEKgDGwTsDXEYHcR6AooQDnaAR5VuqLYqbBh_ijuO9LTby3_w>
    <xme:L5KaYkUUCAMVDBXuf7xrb1fyYaTiF6m_x3uUoNAvbfYtj68ONpkWGCtSt37SR2wua
    yyZMgKFnerzHQ5KPHs>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrleejgddugecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefofgggkfgjfhffhffvvefutgfgsehtqhertderreejnecuhfhrohhmpedflfhi
    rgiguhhnucgjrghnghdfuceojhhirgiguhhnrdihrghnghesfhhlhihgohgrthdrtghomh
    eqnecuggftrfgrthhtvghrnhepkeelveffhedtiefgkeefhffftdduffdvueevtdffteeh
    ueeihffgteelkeelkeejnecuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucevlhhush
    htvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehjihgrgihunhdrhigr
    nhhgsehflhihghhorghtrdgtohhm
X-ME-Proxy: <xmx:L5KaYpL3ogk7OMjPDA98vzo1m5VbFpKUosM_Ja8Ps-i_IwsAKK-NfA>
    <xmx:L5KaYlEBTKB2BM0wtSo-rnXVFrAAaChA_UdzhhjMHVam-mjyAmiYZQ>
    <xmx:L5KaYtUZezq54KMn5h-z2wBJZj1fdw8xwnxH6aXh5QV9SrG3iFcm6w>
    <xmx:MJKaYmPLX_RCmodohQp2mrE-C6I2ViJUDjZWv9TinucnTLB2uNb4aQ>
Feedback-ID: ifd894703:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id DB71F36A006D; Fri,  3 Jun 2022 18:58:55 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.7.0-alpha0-591-gfe6c3a2700-fm-20220427.001-gfe6c3a27
Mime-Version: 1.0
Message-Id: <f336dd51-a6f2-4168-9e4b-1a6dc3d7da6a@www.fastmail.com>
In-Reply-To: <20220602162039.GA20136@bhelgaas>
References: <20220602162039.GA20136@bhelgaas>
Date:   Fri, 03 Jun 2022 23:57:47 +0100
From:   "Jiaxun Yang" <jiaxun.yang@flygoat.com>
To:     "Bjorn Helgaas" <helgaas@kernel.org>
Cc:     "Huacai Chen" <chenhuacai@loongson.cn>,
        "Bjorn Helgaas" <bhelgaas@google.com>,
        "Lorenzo Pieralisi" <lorenzo.pieralisi@arm.com>,
        "Rob Herring" <robh@kernel.org>,
        =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>,
        linux-pci <linux-pci@vger.kernel.org>,
        "Xuefeng Li" <lixuefeng@loongson.cn>,
        "Huacai Chen" <chenhuacai@gmail.com>,
        "Jingoo Han" <jingoohan1@gmail.com>,
        "Gustavo Pimentel" <gustavo.pimentel@synopsys.com>,
        "Kishon Vijay Abraham I" <kishon@ti.com>,
        =?UTF-8?Q?Krzysztof_Ha=C5=82asa?= <khalasa@piap.pl>
Subject: Re: [PATCH V13 4/6] PCI: loongson: Improve the MRRS quirk for LS7A
Content-Type: text/plain;charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



=E5=9C=A82022=E5=B9=B46=E6=9C=882=E6=97=A5=E5=85=AD=E6=9C=88 =E4=B8=8B=E5=
=8D=885:20=EF=BC=8CBjorn Helgaas=E5=86=99=E9=81=93=EF=BC=9A.
>
> I'd really like to have a single implementation of whatever quirk
> works around this.  I don't think we should have multiple copies just
> because we assume some firmware takes care of part of this for us.
>
Yeah that was my idea when I was writing the present version of workarou=
nd.
However in later LS7A revisions Loongson somehow raised MRRS for several
PCIe controllers on chip to 1024 and other ports remains to be 256. Kern=
el
have no way to aware of this change and we can only rely on firmware to =
set
proper value.

I have no idea how Loongson achieved this in hardware. All those PCIe co=
ntrollers
are attached under the same AXI bus should share the same AXI to HyperTr=
ansport
bridge as AXI slave behind a bus matrix. Perhaps instead of fixing error=
 handling of
their AXI protocol implementation they just increased the buffer size in=
 AXI bridge
so it can accomplish larger requests at one time.

>> In keystone=E2=80=99s case it=E2=80=99s likely that their firmware wo=
n=E2=80=99t do such thing, so
>> their workaround shouldn=E2=80=99t be removed.
>> And  no_inc_mrrs should be set for them to prevent device drivers mod=
ifying
>> MRRS afterwards.
>
> I have the vague impression that this issue is related to an arm64 AXI
> bus property [2] or maybe a DesignWare controller property [3], so
> this might affect several PCIe controller drivers.
In my understanding it=E2=80=99s likely to be a AXI implementation issue.

Thanks
>
>> > Whatever we do should be as uniform as possible across host
>> > controllers.
>> >
>> > [1]=20
>> > https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/=
tree/drivers/pci/controller/dwc/pci-keystone.c?id=3Dv5.18#n528
>
> [2] https://lore.kernel.org/all/20211126083119.16570-4-kishon@ti.com/
> [3] https://lore.kernel.org/all/m3r1f08p83.fsf@t19.piap.pl/

--=20
- Jiaxun
