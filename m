Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 069894B695D
	for <lists+linux-pci@lfdr.de>; Tue, 15 Feb 2022 11:33:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235568AbiBOKds (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 15 Feb 2022 05:33:48 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:39238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229448AbiBOKdr (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 15 Feb 2022 05:33:47 -0500
Received: from esa.hc3962-90.iphmx.com (esa.hc3962-90.iphmx.com [216.71.140.77])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 311633CFEE;
        Tue, 15 Feb 2022 02:33:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qccesdkim1;
  t=1644921217; x=1645526017;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=ARGyDK5y8gcDYbJ285np4CQ16ym8E9oPT8mFXA3NHUE=;
  b=bAAosyjtVxYHIK1XuyvdjYle0xNtPIOlAUqpLdK1vFHZW20HlQGCAz5a
   68jOAonWxFyQebAfHFEHLif28UZhvIkhH5Sz4V2vZcyLnoyIfde5iUUhF
   3QReAn2SItkh5f9Nx9Xnzvp3DfU5FF0dmKqrDo5Q1sN8jblEaac+9TGwK
   E=;
Received: from mail-bn7nam10lp2102.outbound.protection.outlook.com (HELO NAM10-BN7-obe.outbound.protection.outlook.com) ([104.47.70.102])
  by ob1.hc3962-90.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Feb 2022 10:33:35 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PZmlR3gVr9zd6r9vwATuOhFS8/Q1bBuLr/6eZWj1zHgLR6PECWALGf3QOH8T2IRhsRAabtypvSWB37zgnVou+J4/I/2I36i7xEYY/XVJkHN0mdGEIeBK126I+FOncsWk+Nw5cyttn1zbLot8Q4KlyDDPumPizkjOD0Azu/5U7DWXg8nV5n3/JLH+bH7u2kDrkrHF3qTzRc/MwKE3UeIPCqqur+IK3PQ/2oB4VYGdnGhr+lI7L3jkAF2/58eBqq8hyKbVeF8ZXBikjktJ8WVbRtIS7J2A2BczjDvURzRe7o0GTL1hFdC0AUC4O6qI27SYFU1IYwMyFm/xPcg6HSMoyw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ARGyDK5y8gcDYbJ285np4CQ16ym8E9oPT8mFXA3NHUE=;
 b=Hqo1O/ydoRQrHBmxk8F1NCtHbSQGDTfxo6VsvmSI4IqKEzHImDxWwEPaXGLURVHOSF2VvWkXaOserpGM9MMe6aF52yal5yBKdBDrAe/4sx0wUvrR/9QMN05isf5vognfhsBa8gas57KEsNsvuYbxsktiQvQldAmYSTnGoSFI1TXsC7R3vzUD/xB3XgnV5DwqnTh9xmd3SLPqte6L+h+OQtIPv2uDMDHt1h8s4OKi3NUwrNJeRWBZCQBErRbxzLcpYp30C19TCr2X1Y8BH5Dwa2HP4K5mRyVKzONvZ9hY8PqYWr82AXO5nBnBQ0FjCyyBzVa/gOtj8MWsswitXFBbVA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=quicinc.com; dmarc=pass action=none header.from=quicinc.com;
 dkim=pass header.d=quicinc.com; arc=none
Received: from CO1PR02MB8537.namprd02.prod.outlook.com (2603:10b6:303:158::14)
 by BL0PR02MB4898.namprd02.prod.outlook.com (2603:10b6:208:58::29) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4995.14; Tue, 15 Feb
 2022 10:33:32 +0000
Received: from CO1PR02MB8537.namprd02.prod.outlook.com
 ([fe80::dad:a99d:81aa:74df]) by CO1PR02MB8537.namprd02.prod.outlook.com
 ([fe80::dad:a99d:81aa:74df%4]) with mapi id 15.20.4975.017; Tue, 15 Feb 2022
 10:33:32 +0000
From:   "Prasad Malisetty (Temp) (QUIC)" <quic_pmaliset@quicinc.com>
To:     "manivannan.sadhasivam@linaro.org" <manivannan.sadhasivam@linaro.org>,
        "Prasad Malisetty (Temp) (QUIC)" <quic_pmaliset@quicinc.com>
CC:     "agross@kernel.org" <agross@kernel.org>,
        "bjorn.andersson@linaro.org" <bjorn.andersson@linaro.org>,
        "lorenzo.pieralisi@arm.com" <lorenzo.pieralisi@arm.com>,
        "robh@kernel.org" <robh@kernel.org>, "kw@linux.com" <kw@linux.com>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-arm-msm@vger.kernel.org" <linux-arm-msm@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Veerabhadrarao Badiganti (QUIC)" <quic_vbadigan@quicinc.com>,
        "Rama Krishna (QUIC)" <quic_ramkri@quicinc.com>,
        "swboyd@chromium.org" <swboyd@chromium.org>
Subject: RE: [PATCH v2] PCI: qcom: Add system PM support
Thread-Topic: [PATCH v2] PCI: qcom: Add system PM support
Thread-Index: AQHYF5a2usnjZ2jVWkWKyemec6MmrKyOIEaAgAZff8A=
Date:   Tue, 15 Feb 2022 10:33:32 +0000
Message-ID: <CO1PR02MB85376D985B785B9AEF4F4426E9349@CO1PR02MB8537.namprd02.prod.outlook.com>
References: <1643738876-18572-1-git-send-email-quic_pmaliset@quicinc.com>
 <20220211091409.GB3223@thinkpad>
In-Reply-To: <20220211091409.GB3223@thinkpad>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=quicinc.com;
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: d370d60b-2ccd-40af-1a74-08d9f06e9d78
x-ms-traffictypediagnostic: BL0PR02MB4898:EE_
x-ld-processed: 98e9ba89-e1a1-4e38-9007-8bdabc25de1d,ExtAddr
x-microsoft-antispam-prvs: <BL0PR02MB489834A4AF1A7B6CAA5F5AAD95349@BL0PR02MB4898.namprd02.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: lTccDuNXvZgUXWgwAXVzBBIiORZU/XA6rxCUXNBQhvK/XQX6DCeUb7sjnf3c7Ukpv+mye0TK5eMPTistNi1QlEvEI9sBWtSu8Vo9HD7aeWfUcTk65MlqEMMIHI2GV91VoDKfB14rxpz1hxvjZKz8J3rbAhEPjvzZRjg/227awIHWEL+KCkptRq6l/X8yUt4hJIoDVgqYU3Rbjl0QOWbJDzdAZzEj84jfo6gasBacU0JytEd3ljL6GXasTd/T+07Qvk1yN/GLeu3H+4jaBozRZbk8XEBZ9b28yp4Y+6XlSQ/+QB7IJtsb7I39JvLtWjV326hcZPAS//Fp0ce3wvCuKrHMufW896vVAiAIWH3BndJLxZKYPlF1midtOxEEC9beKkw8SmyqtEuoreVe/UN82qCUHIkfa4n2dvzfZ4Sev9RITG26/RaXENMtwKdGlzmRZAnJ9dd58f4wp9jRWniKoPM23jcPkYyzDhzqOuUa2stFEUcKX+2CElTfF+y7voLjQisK7QqfsJ3YxMLETwP8yAelbSqF+dX1uK6D+J3zy7Ny6dWZDtz4eP31HN/AfspI8Tb468THq9UdM4BCHpdD7vj5TEMqyDIjOjfuUv8HgCxVWNfaravNu6Ab5ABWsBKHQ44SyMpcfzwHlpMLQW93QC27O4p3N1ZMEW2Vsdvuacp2X6qcvaOGwE+4lJGnMzw5TnPSSvTQ8OPGnPqmekTH2g==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR02MB8537.namprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(7696005)(53546011)(6506007)(8936002)(52536014)(86362001)(38100700002)(5660300002)(7416002)(9686003)(122000001)(55016003)(33656002)(186003)(26005)(83380400001)(2906002)(76116006)(66556008)(66476007)(66446008)(66946007)(508600001)(110136005)(4326008)(64756008)(54906003)(38070700005)(71200400001)(316002)(8676002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?cGE2uZK0TflAGSdTCXlmVM3fB/YnZBTUxQdtyaCMKidXZjwdqyOyf5oHY4FK?=
 =?us-ascii?Q?vJJdWS2EuPRCJvGDMQEy5ST4gkw7ktSOIp5jcmVaycT0YmAkMSgr6Ao0Vqw6?=
 =?us-ascii?Q?RA49H6ygQFkgEKS9hb8ujWu5Zjs59nRYWyyx+7ssZ3RAfw3VcK8plv3PWC0e?=
 =?us-ascii?Q?r9+nMLxBPAMupdhCkqyCXmFq/B7lrJWUIikPuVolC/EdaTDdd76zz4uhSU3z?=
 =?us-ascii?Q?SllJ/3E0IUtqZ97++VgIS2G5/zhZcpFBYDqlICps14mJ8TLq8FVVsNZI8N70?=
 =?us-ascii?Q?veoXWzK0DkGTtLQH+JCrsubte9IBArt8+jHYv9zn01l7+ywHuSRje2xge1Mx?=
 =?us-ascii?Q?ute51QYXFCUewv/egCYQo05ajHgNDA6VuOJFcOwBtOQBB8Z2Ei7wiLQodh/K?=
 =?us-ascii?Q?rl6fhH8n1lodhIeiu44QOQ3qqhujtyQU/b2k6cvcuTO13V/RdCHfMdaLJNir?=
 =?us-ascii?Q?V/1GGBYNfvmfJnzsz/1kARlNnZ43m3pJVA6ARlnd5WrYXPnejdxZBfMXuOCr?=
 =?us-ascii?Q?65/qKSmG1enjE9amrK89dbyp6D5dPJgDEoixnvsUdaPzBIDH3G8Jre0TrdXx?=
 =?us-ascii?Q?jnMCD16l5IC5JYcOQxEhtjQzJDlOGwKjF6Wddd32XFHUAiyERHKZ+MKi1Eh0?=
 =?us-ascii?Q?oCFQZ7l7eymCXOxp0sx8tIaThElXJlxeplU4HBUgRkCN5DH6qgPbghng/hZi?=
 =?us-ascii?Q?gS2+esOwhVAv584OfTsT+Gg8Xp7hol52D7LEywhGlc79fhW+sWaW1ZTiptU7?=
 =?us-ascii?Q?vOXGUje+1mVhiWvfLV5LYIIB+7ztFqDDgePTTkqGSW+XVP3DyEpDPX8iSsR8?=
 =?us-ascii?Q?gstKf0w2DiNf7rYViIZITRa8lIMHhHSxHoAOL75hHfC53twi0hPH6KWlpSii?=
 =?us-ascii?Q?7LbPhbhPxC2IC3f2bDyZx7BiYmXNd/18Qb38WYKddwytACVtOc6bkO/E5bRW?=
 =?us-ascii?Q?vCYb8jtBW88/cKvRnzpC3F1z4eO3WfaWnIeQLLmoGJPLQUPVm+6FegtwWqDj?=
 =?us-ascii?Q?74w2X1X5rMEe7emmjIud21VzyTpZ7fmIsNjFdes9hvoYXCIK9P+9/2Mu3iBM?=
 =?us-ascii?Q?goEuzkb86HhNOM7CyOH+9EV8zg8u7/aJiQ1BnsMBG7LnHE6WuC+phMKbqBVU?=
 =?us-ascii?Q?zQmzT02o2c8MH47W1mwanRfl3nnLfB1hdxw9hqx48kNgGtQTqIIho30eyX/o?=
 =?us-ascii?Q?bxjN9/N2B7+tScJ+PmI3RtNekodhNfnif/AuHJfWQskDs+aMn0tk8O/KHLi4?=
 =?us-ascii?Q?h7iUP/cGnRBaYJKbQZTHYICxGcW9bhZD55XQwXWKNu+8iVMNut6+U+eua9yT?=
 =?us-ascii?Q?A4P4sG2rhOWN8mUxtQbs4wW0ONmcu/LXt9+fUIhbwZfMKicOkrZXBhBK2GyX?=
 =?us-ascii?Q?iIcek+IWvn+TwPgQNOW5iWIHEcbHwshtIxWE5chLaHvzccmw48JhpRqUwtMM?=
 =?us-ascii?Q?Weo1c432bxEIHesNlGBlyGYYD98Ss3v31tUS5QJAc1MowzPoIE6rbNz3CtVj?=
 =?us-ascii?Q?XYF2MTwn7Fvf6mvGc+8kuqmY3Jiu3LLFpXgoWsflnGVGYbjjYS3BhROP4ofp?=
 =?us-ascii?Q?ytqqJvkpj7ob+fy93cB9QTezzusCDWEO5sYWbU6TbdM7DtgHHqdO3l8xSdm0?=
 =?us-ascii?Q?0diykuGT/D6Jx3kgayCs41cRZ/RzkahUVthQxji2i2XidHraDYEcy1ZiSyzd?=
 =?us-ascii?Q?qww0Xw=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: quicinc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO1PR02MB8537.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d370d60b-2ccd-40af-1a74-08d9f06e9d78
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Feb 2022 10:33:32.7505
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 98e9ba89-e1a1-4e38-9007-8bdabc25de1d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: JDTXst75lxo9DUDpmfYABAnsXVm7cEVlnTX4glu1wORQMRH6Qy5ikVbnlDe4Z+25BMyhNLl1X1ZYAXIoUDvYlKWrH2s377ltZYXo0jQeqmw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR02MB4898
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Manivannan,

Thanks for review and comments.=20

Please see my comments inline.

Thanks
-Prasad=20

-----Original Message-----
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>=20
Sent: Friday, February 11, 2022 2:44 PM
To: Prasad Malisetty (Temp) (QUIC) <quic_pmaliset@quicinc.com>
Cc: agross@kernel.org; bjorn.andersson@linaro.org; lorenzo.pieralisi@arm.co=
m; robh@kernel.org; kw@linux.com; bhelgaas@google.com; linux-pci@vger.kerne=
l.org; linux-arm-msm@vger.kernel.org; linux-kernel@vger.kernel.org; Veerabh=
adrarao Badiganti (QUIC) <quic_vbadigan@quicinc.com>; Rama Krishna (QUIC) <=
quic_ramkri@quicinc.com>; swboyd@chromium.org
Subject: Re: [PATCH v2] PCI: qcom: Add system PM support

On top of Bjorn's review:

On Tue, Feb 01, 2022 at 11:37:56PM +0530, Prasad Malisetty wrote:
> Add suspend_noirq and resume_noirq callbacks to handle System suspend=20
> and resume in dwc pcie controller driver.
>=20
> When system suspends, send PME turnoff message to enter link into L2=20
> state. Along with powerdown the PHY, disable pipe clock, switch=20
> gcc_pcie_1_pipe_clk_src to XO if mux is supported and disable the pcie=20
> clocks, regulators.
>=20
> When system resumes, PCIe link will be re-established and setup rc=20
> settings.
>=20
> Signed-off-by: Prasad Malisetty <quic_pmaliset@quicinc.com>
> Reported-by: kernel test robot <lkp@intel.com>
>=20
> ---
> Changes since v1:
> 	- Removed unnecessary logs and modified log level suggested by Manivanna=
n.
> 	- Removed platform specific callbacks as PM support is generic.

This is not still generic... Please see below.

> ---
>  drivers/pci/controller/dwc/pcie-qcom.c | 97=20
> ++++++++++++++++++++++++++++++++++
>  1 file changed, 97 insertions(+)
>=20
> diff --git a/drivers/pci/controller/dwc/pcie-qcom.c=20
> b/drivers/pci/controller/dwc/pcie-qcom.c
> index c19cd506..d1dd6c7 100644
> --- a/drivers/pci/controller/dwc/pcie-qcom.c
> +++ b/drivers/pci/controller/dwc/pcie-qcom.c
> @@ -73,6 +73,8 @@
> =20
>  #define PCIE20_PARF_Q2A_FLUSH			0x1AC
> =20
> +#define PCIE20_PARF_PM_STTS                     0x24
> +
>  #define PCIE20_MISC_CONTROL_1_REG		0x8BC
>  #define DBI_RO_WR_EN				1
> =20
> @@ -1616,6 +1618,100 @@ static int qcom_pcie_probe(struct platform_device=
 *pdev)
>  	return ret;
>  }
> =20
> +static int qcom_pcie_send_pme_turnoff_msg(struct qcom_pcie *pcie) {
> +	int ret =3D 0;
> +	u32 val =3D 0, poll_val =3D 0;
> +	u64 l23_rdy_poll_timeout =3D 100000;
> +	struct dw_pcie *pci =3D pcie->pci;
> +	struct device *dev =3D pci->dev;
> +
> +	val =3D readl(pcie->elbi + PCIE20_ELBI_SYS_CTRL);
> +	val |=3D BIT(4);

Define BIT(4)

>> Okay sure.

> +	writel(val, pcie->elbi + PCIE20_ELBI_SYS_CTRL);
> +
> +	ret =3D readl_poll_timeout((pcie->parf + PCIE20_PARF_PM_STTS), poll_val=
,
> +			(poll_val & BIT(5)), 10000, l23_rdy_poll_timeout);

Define BIT(5)

>> Okay, I will update in next patch version.

> +	if (!ret)
> +		dev_info(dev, "PM_Enter_L23 is received\n");

Maybe print, "Device entered L23_Ready state"? Also this should be dev_dbg(=
).

> +	else
> +		dev_err(dev, "PM_Enter_L23 is NOT received.PARF_PM_STTS 0x%x\n",

Maybe print, "Device failed to enter L23_Ready state"?

>> Sure, I will update in coming patch version.

> +			readl_relaxed(pcie->parf + PCIE20_PARF_PM_STTS));
> +
> +	return ret;
> +}
> +
> +static void qcom_pcie_host_disable(struct qcom_pcie *pcie) {
> +	struct qcom_pcie_resources_2_7_0 *res =3D &pcie->res.v2_7_0;
> +

As Bjorn said this would only work for platforms supporting v2.7.0 ops. Ple=
ase make it generic.

>>Sure, I removed the platform specific code but forgot to remove above lin=
e. I will update in next patch version.

> +	/* Assert the reset of endpoint */
> +	qcom_ep_reset_assert(pcie);
> +
> +	/* Put PHY into POWER DOWN state */
> +	phy_power_off(pcie->phy);
> +
> +	writel(1, pcie->parf + PCIE20_PARF_PHY_CTRL);

Define "1".

>> Sure Manivannan.

Thanks,
Mani
