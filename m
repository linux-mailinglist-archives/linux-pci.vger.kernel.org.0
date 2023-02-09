Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C83576905B4
	for <lists+linux-pci@lfdr.de>; Thu,  9 Feb 2023 11:53:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229710AbjBIKxc (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 9 Feb 2023 05:53:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229740AbjBIKxa (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 9 Feb 2023 05:53:30 -0500
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2084.outbound.protection.outlook.com [40.107.223.84])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2EEC921950;
        Thu,  9 Feb 2023 02:53:28 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nYkF0bO3vEOmFPR4IZLtjrDgtQifyXd+w154SkvPcIjhqlY0DT2X4LTSE/GOeRUybgYXWegGeftf2mfR1DMj+7WZZPu/TLRAd7SVES3ZHaSlFuwt3opsHFeQ7LonWspTHPLn2Qm65upbmdVinGyibH4IjbJbabiY10lOI0r8MW8xVNZt9SWKGtM2BOQJhXWIxTjA/sIK5A0zByRWa/VS9932rJ2FZpbCFXkvRr7oOnhXzW6VxSicVgeNHfpt6EGtpeT7BQQjxwiUA56RXrA2U1MfDAN7gPCdPxsDc0j64KN1swx9ROb86TrnMrisV9ekPTMxjfwbYG7LteaHNVRhTA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=texo4TYrmE29u2JgtGOJgf4ffQ46IxvKjkN+pxQ5s3o=;
 b=f2BHoVPbqMia3YAMhKqLJzLQtj1BYyb7PsdJiZ2Tuvyf7P0tpy/EhjG5cUsov14EOHBpOU18gBWF9Jyt9ua93QevHILnnNiZV1WpB51G7hSZHmAJGtGgPe22Yuu7MgN+SjK/oWEEgxFszSUC+y+P/pjFuDxM9WZPSgKIVaqaYfQGGp0n5qds1naRrwq126OzTgvaommSzsLCe8/lEoq/aPNUyt0WtrQpYm+98cT9RUEcT6yszq7ga6sBR3+k1bnLJqqcSBEBVwx8jRwbWmi3vDco/Hs75t+qd6ielPbH45JnLH1PMndAHtU7TZCdMCb1vL70wttXGg5yFAvtXX3cEA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=texo4TYrmE29u2JgtGOJgf4ffQ46IxvKjkN+pxQ5s3o=;
 b=EzwtLAf92jO9lBkZWbkYG5qB1IbnP8Mss4snr17eS71fX1Cf042aYehWOM8LGV4bikdUK7E9cMChlL3USf9599N6zmSwBYV+oQZNKOUfGYP9VBwMY6D0J+czRQzcpkKGw9Px3mbLKHZjEEWoROEGcJeHnq9KNt/Or3gGk/7Zp8fNXBAaQpm08QAMHb/w+OFlLwbNZpDVGLPyN+Wh9p7nFyLrqZ3+SusWKWvODVG1Ugs5JGdKEWXSwYrzTfOSYqpYHsbl5nNTzoHeuGy3zUQ3LnYW2sIv4ytw3NOlSvk2rfInutnf6eIirRfL09REnCWTBNUcVZCX2lmcBSPQLQ9fPg==
Received: from DM6PR12MB3164.namprd12.prod.outlook.com (2603:10b6:5:188::30)
 by CH3PR12MB7548.namprd12.prod.outlook.com (2603:10b6:610:144::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6086.19; Thu, 9 Feb
 2023 10:53:26 +0000
Received: from DM6PR12MB3164.namprd12.prod.outlook.com
 ([fe80::ce1d:8f53:31a7:44db]) by DM6PR12MB3164.namprd12.prod.outlook.com
 ([fe80::ce1d:8f53:31a7:44db%7]) with mapi id 15.20.6064.034; Thu, 9 Feb 2023
 10:53:25 +0000
From:   Petlozu Pravareshwar <petlozup@nvidia.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Manikanta Maddireddy <mmaddireddy@nvidia.com>
CC:     "bhelgaas@google.com" <bhelgaas@google.com>,
        "rafael.j.wysocki@intel.com" <rafael.j.wysocki@intel.com>,
        "lpieralisi@kernel.org" <lpieralisi@kernel.org>,
        "robh@kernel.org" <robh@kernel.org>,
        "jeffy.chen@rock-chips.com" <jeffy.chen@rock-chips.com>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        "dmitry.osipenko@collabora.com" <dmitry.osipenko@collabora.com>,
        "viresh.kumar@linaro.org" <viresh.kumar@linaro.org>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "steven.price@arm.com" <steven.price@arm.com>,
        "kw@linux.com" <kw@linux.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        Vidya Sagar <vidyas@nvidia.com>
Subject: RE: [RFC,v14 4/5] arm64: tegra: Add PCIe port node with PCIe WAKE#
 for C1 controller
Thread-Topic: [RFC,v14 4/5] arm64: tegra: Add PCIe port node with PCIe WAKE#
 for C1 controller
Thread-Index: AQHZO678uN8JYxCqt0W2Vps0E+YCz67E7AAAgAAKKoCAAEMxAIABLSog
Date:   Thu, 9 Feb 2023 10:53:25 +0000
Message-ID: <DM6PR12MB316420D07FBB9F8CE9AF5CD3B5D99@DM6PR12MB3164.namprd12.prod.outlook.com>
References: <20230208111645.3863534-1-mmaddireddy@nvidia.com>
 <20230208111645.3863534-5-mmaddireddy@nvidia.com> <Y+OJaGY6mcxM0JOF@orome>
 <1b24e9f5-539a-dd0f-6485-5dbf3757ef27@nvidia.com> <Y+PKTNEAuPHBdwqX@orome>
In-Reply-To: <Y+PKTNEAuPHBdwqX@orome>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR12MB3164:EE_|CH3PR12MB7548:EE_
x-ms-office365-filtering-correlation-id: 0c6619bb-e79c-4947-30f3-08db0a8bdedb
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 5BEPwVCa3WJPIWeynlDcPBQRE8k2Atjb/XXo7WKLwzfUYeQ1Cb/4Qs90G5VP0gU0bKFBt5XS5O850yw5tQmeZ0hdXN1r3SIEfrsdl7Vv15asmSywnvuG/tagwRupQsTI8qHp7NlhS28uLgSMkQnUT1OjHrIhm2/NNMsk4ZW3cH1QPaaUCVkPD+vvwsXRMr3TKhjk3u5iIxYxgrqwwdRphrLpEiKwecFTeIXCxOnoss89CR1JAXd2hKHLpPsjaCtOFQhYB/QNmn6Feb53J4x4aV6VMAXQ3SXYAVHoGq/SGnBKN9YO20nJA4vPX8bWpmGd1yb93qHHopZX6YB8BUgThksqj0AFfoeTZs+ipp8DrvGkZ/4DWMJm+ZPNfLhX4LciBx7GUPKHq0UR3ddXSxqW56OFxcdffY4O6AWOslifx9zCOn9K5PYODLaYLkaC/+uguHdxihJPFd8FySFbKiETAGbtbP1Yf8WrQ8hhL6ztYcJBSD2PvlkeWo4Ef4RNUpnKazfUKOQ/gxIsaR12Tt0QEyxmZSbGyKcX5RZXA6b25TmCbzhEMCNCNqo1sacRaQOTGCO3DsZEp7Whiu0BT/kqcpSgX8qQYpzwsYu7i3cqqP6pOVnelLdjEflTaDDDkiALQ72wR0DdlhvSPTBibrqBKIezxgWGJ0js0R1dclve0oYIVy7qHMZHvj7K+1rEU+GoeLu+fhLUkxupTwMYoWmr7SCWRfo5/ZinayAZjWOG5YOyn/FTlQGY/ATeAdZZ/REReVYl8PwIcYHaV5hyumoT1s7kUhwjpRgKxd3mdjsXD8g=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB3164.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(366004)(136003)(376002)(39860400002)(396003)(346002)(451199018)(83380400001)(9686003)(2906002)(33656002)(110136005)(38070700005)(54906003)(6636002)(38100700002)(66446008)(478600001)(66946007)(7696005)(71200400001)(64756008)(66556008)(8676002)(966005)(66476007)(76116006)(4326008)(53546011)(41300700001)(6506007)(186003)(26005)(107886003)(8936002)(122000001)(52536014)(316002)(55016003)(86362001)(5660300002)(7416002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?JYu0Ww5h8HzTwzVsKyF8uZ1yvyg67jshCYIbLvQYA7YlEoY2Oe6fhV4JarOz?=
 =?us-ascii?Q?4Vr/WmUzhsbHg3tDND5OCFw8mHJrdItpWgj1/Qoq3KiOjYcuW8LBFZaocntp?=
 =?us-ascii?Q?R0oMow3LyOks8w8uO0FqYrFEwNE+Fr0eVyGBm+fYVXHpeTb2I3XCRq70WjiG?=
 =?us-ascii?Q?G56JCf7U2VF81bIRyq18BOrYp4Bt7SMK/jt35KcMDpplGRDdFswDQCtoRQ9l?=
 =?us-ascii?Q?34NvQwNSoUtZ19CFGfWPBQROVcasS0mM8asUjux+H2/fGPhKWX4cdjI4pIDc?=
 =?us-ascii?Q?YviXz38kZPCV6I0bF5zokG6vLcpRFCh6hrzW0YCb9ByEhl+7S2FPhgF4EcMA?=
 =?us-ascii?Q?rEKwP4LQothb+pC0V44f7/V14MU3XDr8sZCVacwFKLsohsZV/c2bA2hUJ/lm?=
 =?us-ascii?Q?xA0gQ7iqBBXWYRD5QWxX8mUftEmuq32HGDO+YLTcepSsn9yGVVU1TZ5zgZP2?=
 =?us-ascii?Q?mMTnsCgkxI3qAEM87gJWTe3Ssh9LFzzjQU2mpkeIsUbXPl2DYMCkimDYIXDW?=
 =?us-ascii?Q?Sr7YmjhXMUsTF1xqKvp58Ntw61bgLvS7138welkFmnLr6KGpFt4BWVe0eTXA?=
 =?us-ascii?Q?c4PrwuH9QaqbEkTAviN2cJfvr4cXoPSfRkngalvvx8TBuiUwVHmc4vH7/Tt1?=
 =?us-ascii?Q?/Ar5/pJ6dl9cJM2HBpbv3NA0g8ufm/bR0yfmkpiflxkzcBMmG5wDpbPJzcyk?=
 =?us-ascii?Q?aqttr/iMHOZKVR7zmbthgcoBta0i5lxUazU9iNzC4PLeZTUR9Of7g8Ci7pj6?=
 =?us-ascii?Q?A4jGogS0LMIGcbmb/+mOHD/CGzUjX7/u69XB02I7ua1ypc+nNi2MdBvwp6ut?=
 =?us-ascii?Q?mgJ0nZ1/H9/U9O69lh0Yi7Q7PEnxPvkJeFFYupT+gqig774RDuZgdQHw1MaS?=
 =?us-ascii?Q?cgpn9d3BFE3AhGVuCtxkBTJJ86OWQ30UM8UeaHkD+D9d6SkMAxS3n77/bB2u?=
 =?us-ascii?Q?YVEF2VhPoNaWeWuKYhUbDu4uPsCsrnOhalrvdodautnoD+rNmUVd8nBKkZXn?=
 =?us-ascii?Q?Vbh5nD7fLDEWXGhw+tqJQSy7KGAqpBbmF8+MF9+YM/u3igRDSH+OQz3EVUhB?=
 =?us-ascii?Q?UBHcGZaqMwKWuJ1OxlI8N8o+aTfj/XK/6BXivbdyhqw7ISUyKDA2yuxB4mvZ?=
 =?us-ascii?Q?Ru/uy9C8s8DB16XdmqfSbux9mDzh9k3b7HRCiP1E/40zUNhuVidFDqxRd5vD?=
 =?us-ascii?Q?FKFXJ+dhBBPUvoI4/CSGh7XDTgWA6T7LmBGlf6YhWBmGMqlIsjPY+aS60yO1?=
 =?us-ascii?Q?k0IE2bY8PKo6RmIojcGzzhCqYTg6PGVo0GYQXkAfsQYi9AYfJsEltuesTGXE?=
 =?us-ascii?Q?jka8LAWyNQGFhLgw3h7tXSLk6rZwTAzsnH83IqlnOWvISqY8iW0/9y5VOOZI?=
 =?us-ascii?Q?2xQsEfwudwtgl8Q1ItgwesTmzfegc+UjT43lZw6yHu4LiuoIuA+ixbr+C46Y?=
 =?us-ascii?Q?upbhVUaKGJlo5RKGhzXRNRoneJRe90KmR5Nf9yJc+YSWmFOWpf0D6P7Gc3ul?=
 =?us-ascii?Q?mabbiYRetmVcDsxPYJik/QdEKVKgFfmJwhV3IrGJXSM1nxc0u7J9i5Hm3bLR?=
 =?us-ascii?Q?vD57EacHTEI52JiZVexDzWyHhDSf0mE4guhxoluH?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3164.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0c6619bb-e79c-4947-30f3-08db0a8bdedb
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Feb 2023 10:53:25.8227
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: NnUKH399eaitQhWM8Kzru36cY6A5bRZWhxA2/qGaWO71cGjy1Z3t/lOihBLpWa1Zd4s2KSW3ZyU+IZ7CqySUng==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB7548
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

>=20
> On Wed, Feb 08, 2023 at 05:43:35PM +0530, Manikanta Maddireddy wrote:
> >
> > On 2/8/2023 5:07 PM, Thierry Reding wrote:
> > > On Wed, Feb 08, 2023 at 04:46:44PM +0530, Manikanta Maddireddy
> wrote:
> > > > Add PCIe port node under the PCIe controller-1 device tree node to
> > > > support PCIe WAKE# interrupt for WiFi.
> > > >
> > > > Signed-off-by: Manikanta Maddireddy <mmaddireddy@nvidia.com>
> > > > ---
> > > >
> > > > Changes in v14:
> > > > New patch in the series to support PCIe WAKE# in NVIDIA Jetson AGX
> Orin.
> > > >
> > > >   .../dts/nvidia/tegra234-p3737-0000+p3701-0000.dts     | 11
> +++++++++++
> > > >   1 file changed, 11 insertions(+)
> > > >
> > > > diff --git
> > > > a/arch/arm64/boot/dts/nvidia/tegra234-p3737-0000+p3701-0000.dts
> > > > b/arch/arm64/boot/dts/nvidia/tegra234-p3737-0000+p3701-0000.dts
> > > > index 8a9747855d6b..9c89be263141 100644
> > > > ---
> > > > a/arch/arm64/boot/dts/nvidia/tegra234-p3737-0000+p3701-0000.dts
> > > > +++ b/arch/arm64/boot/dts/nvidia/tegra234-p3737-0000+p3701-
> 0000.dt
> > > > +++ s
> > > > @@ -2147,6 +2147,17 @@ pcie@14100000 {
> > > >   			phys =3D <&p2u_hsio_3>;
> > > >   			phy-names =3D "p2u-0";
> > > > +
> > > > +			pci@0,0 {
> > > > +				reg =3D <0x0000 0 0 0 0>;
> > > > +				#address-cells =3D <3>;
> > > > +				#size-cells =3D <2>;
> > > > +				ranges;
> > > > +
> > > > +				interrupt-parent =3D <&gpio>;
> > > > +				interrupts =3D <TEGRA234_MAIN_GPIO(L, 2)
> IRQ_TYPE_LEVEL_LOW>;
> > > > +				interrupt-names =3D "wakeup";
> > > > +			};
> > > Don't we need to wire this to the PMC interrupt controller and the
> > > wake event corresponding to the L2 GPIO? Otherwise none of the wake
> > > logic in PMC will get invoked.
> > >
> > > Thierry
> > PCIe wake is gpio based not pmc, only wake support is provided by PMC
> > controller.
> > I verified this patch and able to wake up Tegra from suspend.
> > Petlozu, correct me if my understanding is wrong.
>=20
> The way that this usually works is that you need to use something like
> this:
>=20
> 	interrupt-parent =3D <&pmc>;
> 	interrupts =3D <1 IRQ_TYPE_LEVEL_LOW>;
> 	interrupt-names =3D "wakeup";
>=20
> This will then cause the PMC's interrupt chip callbacks to setup all the =
wake-
> related interrupts and use the internal wake event tables to forward the
> GPIO/IRQ corresponding to the PMC wake event to the GPIO controller or
> GIC, respectively.
>=20
> If you use &gpio as the interrupt parent, none of the PMC logic will be
> invoked, so unless this is somehow set up correctly by default, the PMC
> wouldn't be able to wake up the system.
>=20
> Thierry
Thierry,
Since PMC's IRQ domain is made as parent of GPIO controller's IRQ domain,
I think, for GPIO based wakes setting &gpio as the interrupt parent can sti=
ll
invoke PMC logic to program the required registers to enable such wakes.
Related commit in this regard:
https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/commit/=
drivers/gpio/gpio-tegra186.c?id=3D2a36550567307b881ce570a81189682ae1c9d08d

Thanks.
