Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 428DE528DE0
	for <lists+linux-pci@lfdr.de>; Mon, 16 May 2022 21:22:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345383AbiEPTWP (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 16 May 2022 15:22:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345387AbiEPTWK (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 16 May 2022 15:22:10 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9653E1AF19;
        Mon, 16 May 2022 12:22:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1652728896;
        bh=n3B1tFZFIsJ89uIoiL7dX/rVRMmDUZ1088RdBsJpfxE=;
        h=X-UI-Sender-Class:Date:In-Reply-To:References:Subject:Reply-to:To:
         CC:From;
        b=iAqc3i/yie0yQ2RO4KjEodO6JlsmEeoCluKIjQQeD5VvGXK2FMakTvhlaCwZTxZSO
         +AzMBHyTlzQIQMaEQ316PydcD87/HFx5pXYq2+cMNj7A9Gvv91zdDVmJwriY3yGh6i
         6WBPQ5hsPF1ev6OmpV54UGGyP8a06ZCPvBlzup2c=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from frank-s9 ([80.245.74.14]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MGyxX-1o3ajL2Lzf-00E7Xg; Mon, 16
 May 2022 21:21:36 +0200
Date:   Mon, 16 May 2022 21:21:31 +0200
User-Agent: K-9 Mail for Android
In-Reply-To: <20220516173537.GA2942634-robh@kernel.org>
References: <20220514115946.8858-1-linux@fw-web.de> <20220514115946.8858-2-linux@fw-web.de> <1652570081.002742.3276245.nullmailer@robh.at.kernel.org> <trinity-02ad648c-f6f8-4383-b389-a0578d5a02d2-1652615387162@3c-app-gmx-bap15> <20220516173537.GA2942634-robh@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: Re: [RFC v3 1/5] dt-bindings: phy: rockchip: add PCIe v3 phy
Reply-to: frank-w@public-files.de
To:     Rob Herring <robh@kernel.org>
CC:     Frank Wunderlich <linux@fw-web.de>,
        Michael Riesch <michael.riesch@wolfvision.net>,
        Vinod Koul <vkoul@kernel.org>,
        Johan Jonker <jbx6244@gmail.com>,
        linux-rockchip@lists.infradead.org, linux-pci@vger.kernel.org,
        Kishon Vijay Abraham I <kishon@ti.com>,
        linux-kernel@vger.kernel.org, linux-phy@lists.infradead.org,
        Bjorn Helgaas <bhelgaas@google.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Peter Geis <pgwipeout@gmail.com>,
        Heiko Stuebner <heiko@sntech.de>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>
From:   Frank Wunderlich <frank-w@public-files.de>
Message-ID: <9496CAFB-6CB6-4BDA-A539-3A6E1B562299@public-files.de>
X-Provags-ID: V03:K1:f5Irn2u3e6Zhnd5do173aOUv5ETb+hLAEAT30DBf0+1ZrVkoATS
 Fhws/gr/3BwWNsggKEhfSKQkuKdL2wcpALEinrn8h6gKmm20zJmzf3QTFk3lHJlZjBMttx8
 SBN/2jVpFWVUSFkg+pdar6rvQxC24N68914q1lpLgr6mh56mrI47hOdOOiqsN2BIO4LVmoA
 55GtwGo3goKFxsQZm5N6Q==
X-UI-Out-Filterresults: notjunk:1;V03:K0:mRgqnWkK9Sg=:YTdRH5LtJInU/r+qpgpHTp
 RkdHzdHcEvxu7D7CwcHrfaWdoYRljfDrihJYlHodROSRLr7fcp7ZVLDwlAfAj2SQ7ABS6rvix
 FUSMNn7R1Uw/eep6ikgEjSetAPpQ3ovZr6hPl1H26FBChTQX8uEQg0fji9RBXE4hkMfLEYgRj
 qi1IThmmCXf8ruHD3NZF+MtfyAm+yMlowRrf/hAeb494As4sPPs8qjUjZ0uGZ8XKDzi0WPZGb
 pUfNnutYtGbnB129EOlQEMxbdeKCczFMhHimE/8ajesstSfHFzd1JNbjDmDcCg7rpzidmQdXr
 4Z7wy/UB5TcHfzptUdOZZSWGOXNkGMPFiBVhusjhAY2scwkxwXAPd5G++7Q1ZBTagos7sp3pU
 3g5r8paoFTrw0u/zBC5b7THS8qm7ojKQoY3ABU5rBo181Dcax8wW5R9Mwea4ylhEdbmRhL0WI
 HctnSZH8CP89tV+aFOIvDuWKV7y5Vs0MmczPLz95pmq/5AaEwzPCbbjbn2etye/9Rl7tih67O
 D/aHepkA7IUWi6rDA7GSPTa6cXxYNslD7+suV7ReIBLuIdKd3ptfM2xMsofZ6Vg1mwq1dEnVC
 pE4fe4ypJ6EZ1c14gUDANN8b3eGXA+3XqEuO0AqaM71t5Q4CM4rAmNcDXMcHtaVgtUJN7/Xbf
 MzdP+CJo81lBGDeth+6cW8nkP6ias3KfYPNg67lR8Zp7Sb/ErzQPZ3aW7eLTwHrYZsgaX1rvP
 QBBMBjBeK9gib4axMHxAX7UoCGuY2SNoNYqc63ymHbj2Vw8UJVw19bVtqdjXdFiuzZATlDzyX
 MP2H5mKv8T6PlnNdFzn85gFEqS3J07cyApRMrAjM5PFlK7DE4qs4+dspPeOBEHPa18BMnBHT/
 DufwIomMAa2L65GCXfO3zLkPu6ZRWp5vdMNbMvxXO52yCnLqn6beF8z5fRLkoTYh7Wr7nZ/Rs
 CnOGakp5eqt3eMJXbdyPlIBwfjg+0j05Z/hEX55/wYUxOlety08eHvKqD58ZzN2cG77jclmci
 xQ19HjerZpf+P4LlW+Y0ZJ/wm0PfvAjH1E0Xix1ywyrrXTHJrBNH95hpbZWZyOqELguiFVRlc
 flu7VLme4boB+0=
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Am 16=2E Mai 2022 19:35:37 MESZ schrieb Rob Herring <robh@kernel=2Eorg>:
>On Sun, May 15, 2022 at 01:49:47PM +0200, Frank Wunderlich wrote:
>> Hi
>>=20
>> > Gesendet: Sonntag, 15=2E Mai 2022 um 01:14 Uhr
>> > Von: "Rob Herring" <robh@kernel=2Eorg>
>>=20
>> > On Sat, 14 May 2022 13:59:42 +0200, Frank Wunderlich wrote:

>Documentation/devicetree/bindings/phy/rockchip,pcie3-phy=2Eyaml
>> > >
>> >
>> > My bot found errors running 'make DT_CHECKER_FLAGS=3D-m
>dt_binding_check'
>> > on your patch (DT_CHECKER_FLAGS is new in v5=2E13):
>> >
>> > yamllint warnings/errors:
>> >
>> > dtschema/dtc warnings/errors:
>> >
>/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/phy/=
rockchip,pcie3-phy=2Eyaml:
>properties:clock-names: 'oneOf' conditional failed, one must be fixed:
>> > 	[{'const': 'refclk_m'}, {'const': 'refclk_n'}, {'const': 'pclk'}]
>is too long
>> > 	[{'const': 'refclk_m'}, {'const': 'refclk_n'}, {'const': 'pclk'}]
>is too short
>> > 	False schema does not allow 3
>> > 	1 was expected
>> > 	3 is greater than the maximum of 2
>> > 	hint: "minItems" is only needed if less than the "items" list
>length
>> > 	from schema $id: http://devicetree=2Eorg/meta-schemas/items=2Eyaml#
>> >
>/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/phy/=
rockchip,pcie3-phy=2Eyaml:
>ignoring, error in schema: properties: clock-names
>> >
>Documentation/devicetree/bindings/phy/rockchip,pcie3-phy=2Eexample=2Edtb:=
0:0:
>/example-0/phy@fe8c0000: failed to match any schema with compatible:
>['rockchip,rk3568-pcie3-phy']
>>=20
>> seems this is fixed when i remove the "minItems: 3" from clock names=20
>> (which is already fixed length because of the list)=2E
>
>Yes=2E
>
>> needed to change type of lane-map to this:
>>=20
>> $ref: /schemas/types=2Eyaml#/definitions/uint8-array
>
>Why? That's not a standard property though, so needs a 'rockchip'=20
>prefix=2E Though maybe a common property would be appropriate here=2E

Originally it was a bool property named "rockchip,bifurcation" and we chan=
ged it (after comments) to be a more generic property "lane-map" that can b=
e re-used on other vendors/controllers/phys=2E

Driver reads as u8 array and range is small enough for u8 even if used for=
 larger controllers (e=2Eg=2E PCIe x16)=2E

>> then it looks clean for it=2E=2E=2E=2E
>>=20
>> -m causes many errors unrelated to this schema-file even if i pass
>>
>DT_SCHEMA_FILES=3DDocumentation/devicetree/bindings/phy/rockchip,pcie3-ph=
y=2Eyaml
>
>The fix is fixing the remaining 40 or so '-m' errors=2E

So now clean for you(r bot), too? Did only get a bunch of other unrelated =
messages=2E

>Rob


regards Frank
