Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2365378F65B
	for <lists+linux-pci@lfdr.de>; Fri,  1 Sep 2023 02:20:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234936AbjIAAUt (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 31 Aug 2023 20:20:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230082AbjIAAUs (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 31 Aug 2023 20:20:48 -0400
Received: from JPN01-OS0-obe.outbound.protection.outlook.com (mail-os0jpn01on2119.outbound.protection.outlook.com [40.107.113.119])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A423FF4;
        Thu, 31 Aug 2023 17:20:45 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BX+Ei0FgVGMt9/f9QNqBi/sI2tMS4wfqr0wPQ17MRbadYXCvvOI4rzDvTPoZXvKNTAPyiPHHmKrhEefC/ntunpEMuT/dnJYGEMaBeE4boW32wNfXsSTqGKXV8eXtYSW/vKeH8zyG12d3bkjhXcYYBvU4lHkIif8rVLK4HuQa4JJOQqvUR+l2iocBK0BYsG4dA/1wS+NBplA7HXRWxRxyhtUFAiudXXwSRjqfvds0KA/sE5X9CIP9ZRA05XbNRabizenWkvzh+3gWZ/fWIbMLHe9UY+uBFgKNf/uWojy0eyOYlLxYOYc902MLC36pgoK47mYraboPZLJiKZbqNewDoQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=V4pz4nqSBZfK+BPEnHL9HDsqYc+sgIj7oZvUz3EnsTk=;
 b=ij7K8UrzWM6sH+CLjgn/4lWKEUhK0VcKSNScUSv1bRiO5i5wd3towLhpb12toUhU2caVbri3r21DRMW8uWspdJ34mWXGj+9/lpv3Cw1pmUqwSC2relo9Cn2ATD9rRkJR2SKaNMyoY9bTZYPc6l5wsu6lVj1dw/aAL7Bffa00ettwV8565YFIezFnYo+K9iba1a2yAeKnpASId7jBDbNO/9dW5Np5/v15vjiW21s/mNL5pcmkdw10rlBciMXF3SUrJfF0COWD0ldpwb/n0j3xk65jGggmLr2p500WFtbcGqz/2EI2+HehRWCIgSKdGXzH2rZ8pHSlsxuL0eP69A/1HA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=renesas.com; dmarc=pass action=none header.from=renesas.com;
 dkim=pass header.d=renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=V4pz4nqSBZfK+BPEnHL9HDsqYc+sgIj7oZvUz3EnsTk=;
 b=HVxWrjkiMQZ7BQC0JoLQCNqymyGs+eNfMadyIMcJY2eVEMTZJJOiaXws82rXqKUPSdFyEOsUWHYzjwRv1OW+op8B4YSmJPRAYYQrZr6NJsc0ZRlUuxEnJfd1RHhMzskmUmV6RIkuiNj6SGuvefw9DOECrS32KR2PpJQQVLXxNdQ=
Received: from TYBPR01MB5341.jpnprd01.prod.outlook.com
 (2603:1096:404:8028::13) by TYAPR01MB6137.jpnprd01.prod.outlook.com
 (2603:1096:402:34::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.23; Fri, 1 Sep
 2023 00:20:42 +0000
Received: from TYBPR01MB5341.jpnprd01.prod.outlook.com
 ([fe80::e5cd:66a0:248f:1d30]) by TYBPR01MB5341.jpnprd01.prod.outlook.com
 ([fe80::e5cd:66a0:248f:1d30%4]) with mapi id 15.20.6745.022; Fri, 1 Sep 2023
 00:20:42 +0000
From:   Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
To:     =?iso-8859-2?Q?Krzysztof_Wilczy=F1ski?= <kw@linux.com>
CC:     "bhelgaas@google.com" <bhelgaas@google.com>,
        "jingoohan1@gmail.com" <jingoohan1@gmail.com>,
        "gustavo.pimentel@synopsys.com" <gustavo.pimentel@synopsys.com>,
        "lpieralisi@kernel.org" <lpieralisi@kernel.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "manivannan.sadhasivam@linaro.org" <manivannan.sadhasivam@linaro.org>,
        "kishon@kernel.org" <kishon@kernel.org>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>,
        "conor+dt@kernel.org" <conor+dt@kernel.org>,
        "marek.vasut+renesas@gmail.com" <marek.vasut+renesas@gmail.com>,
        "fancer.lancer@gmail.com" <fancer.lancer@gmail.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-renesas-soc@vger.kernel.org" 
        <linux-renesas-soc@vger.kernel.org>
Subject: RE: [PATCH v20 00/19] PCI: rcar-gen4: Add R-Car Gen4 PCIe support
Thread-Topic: [PATCH v20 00/19] PCI: rcar-gen4: Add R-Car Gen4 PCIe support
Thread-Index: AQHZ1zcNtDThJaZvc02SH965eUO1lK/+WEaAgAVM4qCAANSDAIAAq2cg
Date:   Fri, 1 Sep 2023 00:20:42 +0000
Message-ID: <TYBPR01MB5341EB69E1C14EF5FA459B16D8E4A@TYBPR01MB5341.jpnprd01.prod.outlook.com>
References: <20230825093219.2685912-1-yoshihiro.shimoda.uh@renesas.com>
 <20230827162721.GA2932694@rocinante>
 <TYBPR01MB5341A56DBA3E4335FE8A35F0D8E5A@TYBPR01MB5341.jpnprd01.prod.outlook.com>
 <20230831140426.GA255922@rocinante>
In-Reply-To: <20230831140426.GA255922@rocinante>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYBPR01MB5341:EE_|TYAPR01MB6137:EE_
x-ms-office365-filtering-correlation-id: acc64b9b-c7bd-4a6b-285d-08dbaa81475d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: KvfgnjqKN5RpXZm0L6KVsE1LvP1+9TWDIXBHq8yqCDWZ8tCxLRLVnaLcmcLIBhJRF6teoZSV870+bSp17SdGwdrIzqV/36/8CLuLKqtMDPBdZ6ez66jbv43kzxQzW0jM4DDvgapXTfPNx4hUVFHq4jU7jJ3utkp9eKVMRUuKc8rs6sIPtpv7J0ZBJxQqIY4bB09AtimwEYjneikb8b1jsBKXm8jIijJ2NMGQhCrMnxT7CsNUxdjKduFWNBRyWPQ3+s/UDdrJk9n5G5CmK+yNLMsZscZkeLH4UR4qfcVfwKaRkRh9pghhMSauxSIQ1/SdwVGyc8COFY0MIsH/9rlJ0Nvlj23DjOMOY1USpxFHPXHohpCigrFTV6Ego7CFslWwI0IhWq2y5lrZPtSv+THHpwAWFkDRNz8J+A+U+VXFXymbyfSC5N2QAg+YQB5hwiCFKA4/S4VhtKfIyFrUgngfr/uXSfMT3uDD/sl7JlZXW1s5XQ6jt8LoQ4rKThGlrZax8Cgqao0Qm6tBx7SwDBZyxg0Yh8Hbf0rXyuiu0zswMiyJRltmxny9JnR4kpV19dmqylUxtsfR954xmaYBPdB/o10fpy52k3cJuuaQG3l4yMZUk+t+2Ri/xdQgFyQliFvf
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYBPR01MB5341.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(136003)(396003)(376002)(346002)(366004)(451199024)(1800799009)(186009)(38100700002)(38070700005)(64756008)(66556008)(54906003)(66476007)(76116006)(66946007)(66446008)(9686003)(7416002)(122000001)(316002)(6916009)(86362001)(6506007)(7696005)(2906002)(33656002)(41300700001)(66574015)(478600001)(4326008)(8676002)(8936002)(71200400001)(5660300002)(52536014)(55016003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-2?Q?DKiVx4nHO7Wpx4mHOxrhvbkzcFz7iX94fIW3ld/6D7meXFMMONahBqjjfK?=
 =?iso-8859-2?Q?8K2WnWMLpb4Z8ngkpugXFKKvaGL3OdFSggZ+sMNbzUfvJQwEvftIxJ1r5z?=
 =?iso-8859-2?Q?7hbijtUH90JdX7OUR2+MJNIiz4Q0RnluN1HDnRyzbT1JaBV4oeKiM0SEIb?=
 =?iso-8859-2?Q?DeRxD6WDiSl1u49q0idLo/4Pe+uR2240EKU96sXuT1gfE8j22f/SIBb2Fk?=
 =?iso-8859-2?Q?/R293BPR9hlga5hBncIU4nI5z/BfzQKJpjVFUrzqvY0obbApPbXMKslFxW?=
 =?iso-8859-2?Q?BtKh/9IrUnWp4Ke2yWL8osEqxv4h5FspGFX90CkLVyMn9wyh8zm2W86uyc?=
 =?iso-8859-2?Q?w4BftZQACcjeMEdqmnZXKog/ZD3H16diOuHirgAfZRwXWNBOt7XAr/wQyV?=
 =?iso-8859-2?Q?wWVbztmY54qdhzQ/jtDRWpvb8u4Wv8ca1CRmYiuisNvcIkNWXIqY4DQJ2S?=
 =?iso-8859-2?Q?+WylnqaSn5EZw+QVSF5ypyXpS0GolFfw7qFkKA8iG+7UIJXTm011//+f1D?=
 =?iso-8859-2?Q?pT/DWvFZ5VQA7OX1ytd1WTEVEWMcW+2S940HcLm86B1QuRlShnO6KWSm5i?=
 =?iso-8859-2?Q?VBRoN3sZOlV7BjkS+ZGPIXR2gJPl1j9SDlkkYaAQ20MO6ZN+Cxe89g20BH?=
 =?iso-8859-2?Q?wGN4OmKxJpVE6POpNCa1j19v3jgP93PcvkvbBMI6rxlq7ZowqbvXC7AF2U?=
 =?iso-8859-2?Q?w7z3NG5d3RkaTMz2PZSK0Bq34br6XJfoqQ502J6aGx9nADZAZ4bhmtU3az?=
 =?iso-8859-2?Q?KZgsIEUFNJOv+yOggBYhkFOxGVWr0AeBkFyJvF57MGr5xbHA66TXYJihyE?=
 =?iso-8859-2?Q?wIAnNma0+tForKeaHyvsAIS5MIdZ7J0Wf9xIYfvP5gFxUPteusU6BWv77Y?=
 =?iso-8859-2?Q?3Bn93k2/Hvm+0QciRYrGYB28FxX4eN1Qsm597YSr+k8B8Ios/+Ej6BPIZZ?=
 =?iso-8859-2?Q?SJ/jZGHy9Tx4F/OShfbHkcXB5tnWE2NZRT1ZuytFB+zcQ+FvbENgF7gxR/?=
 =?iso-8859-2?Q?+px+5UsAtIiHO45wuI/uV+gSan1zm/p47fys9C6Bze4kUd5/Tv9A30m5GG?=
 =?iso-8859-2?Q?OTcx/BZSfI7/eUrxt0Y9aTzFKZrc87mlKjgK25C4P/dW0C7iuDEcmm1U0D?=
 =?iso-8859-2?Q?hCfEYH+JLhNNWQpjO1tOKEzDnzy/YgQmqm8sHDyxv1jrSvqqdsHK8oezew?=
 =?iso-8859-2?Q?rXqIx012Od558tMpWKZqOpJsC614qlWb/SFjc+mBAl8RnaRmfzsLMm1lwk?=
 =?iso-8859-2?Q?eHLV3RSysf69vw7nIuw4xwQZ3Tx8f1dWeABC11ZxhrpWzYubdBpI+IDKEZ?=
 =?iso-8859-2?Q?+gl+uf8sVCmHW+2GW/kcLwN9MRq4063MfgH4vK3qLc9nOQpB+8MOfTuSVD?=
 =?iso-8859-2?Q?obO//jMV8++YPpiWqIfXvRTJF9zvkLVN+eTvXHaqLQ3gIbtT9dPg6yzhqR?=
 =?iso-8859-2?Q?lNBQLzTurCmNAC1UHSEBaW3cf5kKX/yHeK4NpE0ioIo8umFCiGNacCi4li?=
 =?iso-8859-2?Q?uu1cD3AOKF6Sv/xz5GrrO0thqtgCmKgpu51vzHDwfcsdKwABZeoP8sWU20?=
 =?iso-8859-2?Q?erArYUvCi6P9T29EErHz/0kWoSK06cspKs9J2YDM07nBTspf81SrzMVFBT?=
 =?iso-8859-2?Q?Q3hrrphDXlmAGBHn+IdJua/adbCDWmQsQOGDAx2XfOytiA/KMEf5Mfcuo9?=
 =?iso-8859-2?Q?jAD09dzydxF2kL1NlBsxgEBAWExIqx5oVm4tN3KdFNWbQ/EmdYGTIJFCTY?=
 =?iso-8859-2?Q?7/iQ=3D=3D?=
Content-Type: text/plain; charset="iso-8859-2"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYBPR01MB5341.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: acc64b9b-c7bd-4a6b-285d-08dbaa81475d
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Sep 2023 00:20:42.7685
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Q8f5nn0AqxdcGPvnrkB0xbhV1IqDrjXnHGFSY4Wl8Ey/TcGa4i63W0o/kMEXOLOCvcc84gQq3b5YnCLXrPN/a74HKerpOWr+Z0+pDBIZq2Nvws5xyn2qfVMi+vwzQs8F
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYAPR01MB6137
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hello Krzysztof,

> From: Krzysztof Wilczy=F1ski, Sent: Thursday, August 31, 2023 11:04 PM
>=20
> Hello,
>=20
> [...]
> > > Applied to controller/rcar, thank you!
> >
> > I should have asked you before, but is it possible to merge this for Li=
nux v6.6?
> > Today I realized that "[GIT PULL] PCI changes for v6.6" [1] didn't have=
 the controller/rcar...
>=20
> Bjorn chosen not to include the series as the scope of the changes also
> spans across the DWC code base, not only adding a new driver, and he want=
ed
> for it to remain a little bit longer on the -next, so that if there are
> issues, we can catch things...
>=20
> ... like the dt-bindings issues that Geert is asking about.

I got it.

> That said, there will be no need to send an entire series again, if you
> have anything to fix there in the dt-bindings or the dts patches, and jus=
t
> send a new patches for these - I will pull and squash everything later.

Thank you for explanation about how to fix it. I'll submit new patches for =
these.

Best regards,
Yoshihiro Shimoda

> We are getting there. :)
>=20
> 	Krzysztof
