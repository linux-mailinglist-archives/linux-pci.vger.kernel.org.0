Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2A4664343F0
	for <lists+linux-pci@lfdr.de>; Wed, 20 Oct 2021 05:39:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229846AbhJTDlT (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 19 Oct 2021 23:41:19 -0400
Received: from mx0b-0014ca01.pphosted.com ([208.86.201.193]:7360 "EHLO
        mx0a-0014ca01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S229555AbhJTDlS (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 19 Oct 2021 23:41:18 -0400
Received: from pps.filterd (m0042333.ppops.net [127.0.0.1])
        by mx0b-0014ca01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 19K1chwD004401;
        Tue, 19 Oct 2021 20:38:50 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=proofpoint;
 bh=kkzC3v39pXt5cT0EaAWdCRz2tQajUTtyMIZaBlp7htQ=;
 b=PiyJW9YjWtTpF+rfSst9PtvW3hA0VIbNe04kAEHvn1jiiv3a4aNf1fye1lyrI5QY+fav
 YP3lNsLWFHYLkKhmdnNtgq/sZ5jDrUjOsaZYEcKWTedohT+nS36xUNyI0aH8Cbcdsyb8
 jh05jHiRbPo3YS7HRPcRd3yVct9whgLAFj7yQizT0CbEmtenWTWlyYMgYmY8FrvkT1Ww
 8WvTLFv/PeM3Yqrxzexte5D9JWUanlOSr0n2DcwyxnNs6+S/4FZoJe2OxDzM9JYCilxf
 359UiJIeOft+brqPAHJPOz10/aKJnqVb9dpeyWT6XF2Rn17I1+sT0qtSFUk/mzan8+Xi ig== 
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2103.outbound.protection.outlook.com [104.47.58.103])
        by mx0b-0014ca01.pphosted.com with ESMTP id 3bsk6ww4u2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 19 Oct 2021 20:38:50 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OZCz5YVylcWYLld62NeFdWMuqyPfymrbnHYeiAzy5DyQW94377I1xo4zcsLZk7ohvv3OX+tlC2wFYvYNIukPhZrNvTbgeFVUxYWfnTVVnqTZZDz5TwidrXUoPbleSQzqMOLNu2IpCW1Gf2Wa9AvASi5cK6/jpJWHxI9sB+EU+K0xpJI9/+B1uCWwJyPY+D3IyxXbPc6B7yE5AtXvlYpQRtpN4Saovv6tvyp2ME8b2mxGt7oFgVGC1bI0isDaXduLSjmcXxmLFhtdKi4m9fgJHGq4tcY9ROQDUvtLjVyWgWApOJVOJqT7z+VFys7iIniVHuXs4HZWKK4B18cEngDgMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kkzC3v39pXt5cT0EaAWdCRz2tQajUTtyMIZaBlp7htQ=;
 b=OpJEbp01yibptMX+XzSEAr2RIM32aHqAVWEPGXpZ/84wpk7f+LQIBWz5t67nl+YBwajBtfxMQVscBa0Akfgj0oalqgulPCBkQN79H0OBPrWZLDVM5dfszQ6m5fUKi3qLW3k4NkM3c+YT3DS29UT78HEkrlovorRC38BzNzcBcu6V96nw2pmWRrZt3s3G6ZlC+AteOsKNDWUmL2cYYIcXZdgKmRKUO4C0UcKsJPTWt6IaQNJrsRsnI9wfpOVuSucPV0ziFU7rEbmIjpL/aB8K560YK/VlpGF/lX+9ppG6fIL2se1WOD7ut5lOAbNkDRCs3+9xC2/uz1OM7dm6o6bUjQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cadence.com; dmarc=pass action=none header.from=cadence.com;
 dkim=pass header.d=cadence.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kkzC3v39pXt5cT0EaAWdCRz2tQajUTtyMIZaBlp7htQ=;
 b=y3AxtyLxnThTwH4x75rbyNIsapNftlbYrXBwKQCX56EknSxerzyZoKZmXzI0wuWwbNM0MaZ/YKj7jnIliMvVi+ebiM7cccw+u2DnVEMGYgiEdQM/L823X33vcDb/y7KP/HsMYTjhCF7C3Q0cwe1WTI7n4axeNfdoDwguMeezqns=
Received: from CY4PR07MB2757.namprd07.prod.outlook.com (2603:10b6:903:22::20)
 by CY4PR07MB3605.namprd07.prod.outlook.com (2603:10b6:910:76::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4608.17; Wed, 20 Oct
 2021 03:38:48 +0000
Received: from CY4PR07MB2757.namprd07.prod.outlook.com
 ([fe80::903b:e71d:a584:9c87]) by CY4PR07MB2757.namprd07.prod.outlook.com
 ([fe80::903b:e71d:a584:9c87%3]) with mapi id 15.20.4608.018; Wed, 20 Oct 2021
 03:38:48 +0000
From:   Parshuram Raju Thombare <pthombar@cadence.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
CC:     "kishon@ti.com" <kishon@ti.com>, Tom Joseph <tjoseph@cadence.com>,
        "lorenzo.pieralisi@arm.com" <lorenzo.pieralisi@arm.com>,
        "robh@kernel.org" <robh@kernel.org>, "kw@linux.com" <kw@linux.com>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Milind Parab <mparab@cadence.com>
Subject: RE: [PATCH] PCI: cadence: Disable Function Level Reset support
Thread-Topic: [PATCH] PCI: cadence: Disable Function Level Reset support
Thread-Index: AQHXxEsGD19CGPKz3UqopILaYcgccKvZJ+4AgAIXBbA=
Date:   Wed, 20 Oct 2021 03:38:47 +0000
Message-ID: <CY4PR07MB27579495272871B120875A83C1BE9@CY4PR07MB2757.namprd07.prod.outlook.com>
References: <1634580445-89772-1-git-send-email-pthombar@cadence.com>
 <20211018194218.GA2248370@bhelgaas>
In-Reply-To: <20211018194218.GA2248370@bhelgaas>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-dg-ref: PG1ldGE+PGF0IG5tPSJib2R5LnR4dCIgcD0iYzpcdXNlcnNccHRob21iYXJcYXBwZGF0YVxyb2FtaW5nXDA5ZDg0OWI2LTMyZDMtNGE0MC04NWVlLTZiODRiYTI5ZTM1Ylxtc2dzXG1zZy0zOTRkZGNkMC0zMTU3LTExZWMtODY0ZC0xMDY1MzBlZjIyZjVcYW1lLXRlc3RcMzk0ZGRjZDItMzE1Ny0xMWVjLTg2NGQtMTA2NTMwZWYyMmY1Ym9keS50eHQiIHN6PSI3MTkiIHQ9IjEzMjc5MTc0NzI0NTExODg0MiIgaD0iSGdHSWY1MkM2Q0dlMnREeG1ZQ0ZlYVl4Sld3PSIgaWQ9IiIgYmw9IjAiIGJvPSIxIi8+PC9tZXRhPg==
x-dg-rorf: true
authentication-results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=cadence.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: dfbb60c6-50b0-4274-ced7-08d9937b205b
x-ms-traffictypediagnostic: CY4PR07MB3605:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <CY4PR07MB3605C00D87AAE9242D47F40FC1BE9@CY4PR07MB3605.namprd07.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: QjsCdGBXUGDO48P7zSC+Psvp/QyfD4o+wdE/v5HWSYXnMENYNxKDjFnNxzb4uwXoMlDFueJ44OrQkSEQeTDK/jYsiEPNqcqK6NpQE8HD+ZiilEORRHvAS3pI5bRBYWkoNbpIeoVmQmhNdrAmfsx3kVdgkFRJ8IlpT0gkofDnErpt/nZk+a2eA7o0zNQVgt/W0/vW8njD4O8lP4uZJ4gmob56j3Xg7ANRpSwAz3Z4fgc1NBsKCZoCtH1HKUJaYbfN8pizninwsrPvV+YQGlmIUau7PGXGK8dqIdaSJ8vhU6Xjrichd8Ef1GdeeCst+EFwFHzbnbDSDA9/4AS30I1KRw7hlrH52AjDFf4ih1RHoproW1wijBbPwlTTNTc/h1qWuzTixXOJGgyWZ4QOQVbub/GWfDNFS86dk/wNOaUyreMKRR1yAgKVnz268fr8yTbyl1GOQ7eCVpL1zHfro7ym8l13noRB0BE3bikx281WRa01XlUfDlmaQACczrij7QGpTUe7heUnR4WY5osSZpzx/cb/3qZ7QT5RFlpJklASPXaYxQ9YdvVKmY6XJfMquAkVun9NZgxA/4sfSsnbOsQ+ILrdnmrUAk03y4PvDiVB6xDpvAZfRtI/81PXRmuxJ6fSz+65kwr4W2C7pn2bJZB8vft1+vQG4RGlJ0dkqELYk1vJU53RFGaOFBdaBTTgECBmiju2R1CI3pbNDHwjKwIMeaxwEevy+0DIjplVl01QoT5V/MLWjtzkfMWKYxL5BtaG
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY4PR07MB2757.namprd07.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(36092001)(8676002)(66556008)(76116006)(64756008)(6916009)(54906003)(66446008)(7416002)(66946007)(8936002)(107886003)(66476007)(38070700005)(38100700002)(71200400001)(6506007)(26005)(2906002)(52536014)(5660300002)(316002)(55016002)(33656002)(7696005)(4326008)(508600001)(9686003)(186003)(4744005)(86362001)(122000001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?0Mv6KQg12f0sYq6APylf4NWYeOiqxRfdQXYbOmU2jmFCBSu/29zilWAsFcNR?=
 =?us-ascii?Q?st6lPw8ME3cq771K8gturVlkoGJshVuqntoznnDNjFc4sESX0kKcPJWQzwAX?=
 =?us-ascii?Q?d5i4ni36DO/m5FXDZMqm1wbxdPll2nDdrMYNJDC+vS2V+tXizoYVjDMaZR20?=
 =?us-ascii?Q?2NhWt3IZ30tJOhOHCgq77hGlxtimpoApWZVD7D3iTPOS+c5h06FAe2s7xy2O?=
 =?us-ascii?Q?TTZxeFJ4E+oH7/TPgaI1cL+F3ltFlk2QlttXlEnOPdE0hyodHs7XjSjvfEow?=
 =?us-ascii?Q?KUnPWz/fPBhx2DkGIaBq5kc9oyZFwN5l+Gt+X3L6mpMxA8CkRPEJHmPgKJ0y?=
 =?us-ascii?Q?3yPjq8Adw441InW8VSz+AjpG8aic8lLP07Y450yB++KVbkugQNDqtxIBokEq?=
 =?us-ascii?Q?JfflREou6pUk2mQW0Fc3WBBGSBzLyjv7rr2Alcfj0i10G0XZCiCf3dPTy/3l?=
 =?us-ascii?Q?nqB9gBHqS/o0ePFcUO5ZNAtc/WtnntDmtiN2L9jjB6lfm62aEe4AFfRgIjF9?=
 =?us-ascii?Q?d9mXbwQhwcEYYumQUcZedQho9ZbsBWpKXvCnh+Qq3Dq9YzYBOZHlLfEks9cb?=
 =?us-ascii?Q?RLwdas0sKCq6TlSgrECz46fK52h0Kda5y7VH9EIUKRCf5s+HeAWbDj+sy3JM?=
 =?us-ascii?Q?N3bNkpGnIH106EA9HopY1Q6taIunJw8hIQLyotacEr9fJiaK5SZmnaJHXe6t?=
 =?us-ascii?Q?M5oGydfIxag/wOCGVA3AXjQlTAAbn0R5YJSW9MrQxxXgRKRnhm4/F8IwgSr6?=
 =?us-ascii?Q?4201VyYkL8DZZNaZ8UBzOP8abTbQBydPZu97OISLaKfFUaDAP5p6IuWurCUp?=
 =?us-ascii?Q?DhBWgGi61R92MDUWlWGbNyrdFv1yDhsYD3Oe8pffF8M2vc+O4tTHe4yi3Tz8?=
 =?us-ascii?Q?+NFs6RvzY05EnE2knX0vOP9QD5et/v3dZFlhEdUYCZ/sC+asSnR80AjaRm+K?=
 =?us-ascii?Q?NtpTRzjfdn+XDgSYmzerl+gYWxu99oizgePtrcu3zq0oUxb/Zu+7WgjMDuTK?=
 =?us-ascii?Q?7r9CZfNozLZI/HJc12+gReB39HH6TkRRwqRSY8fhJd27WQvwyilsEF0VbGjJ?=
 =?us-ascii?Q?KF7j0mscQ3Tv4D+ABkyYCvF7rMeeh4nUXcMgKHoCSv+UbIThIDKZWon/tYfd?=
 =?us-ascii?Q?7wUpP+/tEVtNkeQfvVtF6U/2sb8SipAfex8Poc1QOM+2tIAOb9fo9eqvcvo+?=
 =?us-ascii?Q?1XMoENNpXTyjiVnwgmtoktyeOhMP6boVyksfPfidbabIzAY6R64yQ27a6zbs?=
 =?us-ascii?Q?xZiRGlBEc+ya1r0kzMexJL7/L+WqLtBN7bvvJRyFjfd1xWWhKZZtEoSlamCv?=
 =?us-ascii?Q?J99bOgjWF9TSSEyoisMsm8Yb?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: cadence.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY4PR07MB2757.namprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dfbb60c6-50b0-4274-ced7-08d9937b205b
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Oct 2021 03:38:48.1634
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: pthombar@global.cadence.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR07MB3605
X-Proofpoint-ORIG-GUID: H2QfgnNlQZrsYGfSsXrdzMbWBGrLmGR6
X-Proofpoint-GUID: H2QfgnNlQZrsYGfSsXrdzMbWBGrLmGR6
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.182.1,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.0.607.475
 definitions=2021-10-20_01,2021-10-19_01,2020-04-07_01
X-Proofpoint-Spam-Details: rule=outbound_check_notspam policy=outbound_check score=0
 priorityscore=1501 lowpriorityscore=0 impostorscore=0 mlxlogscore=621
 clxscore=1011 adultscore=0 bulkscore=0 malwarescore=0 mlxscore=0
 spamscore=0 suspectscore=0 phishscore=0 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.12.0-2109230001
 definitions=main-2110200015
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

>Add blank lines between paragraphs.
>Write the text in imperative mood, e.g.,

Ok

>  Disable FLR (Function Level Reset) support on all functions.
>It looks like this patch clears PCI_EXP_DEVCAP_FLR in the Device
>Capabilities register.  From the point of view of Linux, that means
>the device doesn't *advertise* FLR support.
>
>That's different from actualy *disabling* FLR support, but maybe
>there's internal logic in the device that ignores
>PCI_EXP_DEVCTL_BCR_FLR when PCI_EXP_DEVCAP_FLR is cleared?

Yes, this patch is just to prevent device from advertising FLR support.

Regards,
Parshuram Thombare
