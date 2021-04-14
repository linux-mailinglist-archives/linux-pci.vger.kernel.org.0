Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D1DA635FAA9
	for <lists+linux-pci@lfdr.de>; Wed, 14 Apr 2021 20:22:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352591AbhDNSQs (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 14 Apr 2021 14:16:48 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:41820 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352972AbhDNSQA (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 14 Apr 2021 14:16:00 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 13EI5Zpg114573;
        Wed, 14 Apr 2021 18:14:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2020-01-29;
 bh=Unt7Z5rvosxdaGkZMIDfPCj+8vZNmYQLGuv9hM3qp4I=;
 b=iAZ83MtMcYtMzcwwORGKDFJBvAnDGoAdilZfZk42Z78oJ5CoE6skdzO8GEPmrCjrLCoh
 phDNPoa4QW1L68oe3vbEaA9g3yesuhI51CsWDQ/E+t8NQZ88SqLOF1HtH4bLKZoTu0Vd
 IsCu1XCoe+Hs3tLS3YaolLh2qzt32oQNs6cNxJ3XsgtCt9XyAyjx4/JPxKJbyoPQGth5
 qyecIrKDpLBO27lsUK+W5wp91bqImyKBdI7fE/xUmuYwyOM3ZI6qGUZDWo91/+g1zAeG
 q0rVHND9qSfX8kXFELvFowfYda9VaD6CkA1YxP3UKvoono/CMMqHk3595bg0ltdIgaai Zg== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by userp2120.oracle.com with ESMTP id 37u4nnkc8b-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 14 Apr 2021 18:14:41 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 13EI5Zhv110201;
        Wed, 14 Apr 2021 18:14:41 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2043.outbound.protection.outlook.com [104.47.66.43])
        by userp3020.oracle.com with ESMTP id 37unsuc3c2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 14 Apr 2021 18:14:41 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LliF92XMfjRv0c/TNlk57Skeyo3nb+cfG/Gp6qXH4N7ntPsN65a0x0N1EiK/nEYE5ouNpY3t6iSWAQZ44OdaaK5dgdUdYRm/olavfbQrkDVkq4sYU9jgkuHNpo2+yE+Up27NqzCPEKpbWKP/H8JZNjr1C3BVMrtQDwkHuenIMRa+EoGSZ0RkQ2VIE7aEUxpIrYIVX1LdauWb54oMf2RytRkIn+SaNlvgGeORVRsInHyZCmMreU1lvoPtzJS1JQICtj1td0xrMHmwHY/MJ8nPspn41Uz7XccQmlyuOOorYvx3gooG3W4cFb/oIHI5dAf3+/NGchy+82jDfBBz/03z2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Unt7Z5rvosxdaGkZMIDfPCj+8vZNmYQLGuv9hM3qp4I=;
 b=n1wacu5C4MNbW+QG2ckpmlX6C471OdTejHv9GHK8QS2M9njzrKadYv5S4w1gWDWlABJ+nwopACHxuYh6Wi3p7sswAa4quhIwke2Llc60aPUOVQyP4sc0nfDOqUezA2YcLGyRw8I/hrDX0nGftNlKlaLzM+9KKJk+J8HiTUlifEe/Nq7PHPMVQlgziiFwiqUUmL5O7SATMZqOu+FtLtOCuMYwMLmAgVUrm2IFxnGfLFy5eqI9p6To0CAXTd49ErjgxJDax6QD33RxlwL/hNEBCcS4jHPUqPv8LtKclfcvA5LD9RFnz5zZFLnpQM7D1KrEwf48okF5d4SSPlWU5x2IqQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Unt7Z5rvosxdaGkZMIDfPCj+8vZNmYQLGuv9hM3qp4I=;
 b=mUx8nCGiAz3OgmFhR0nzthFYGzT21Im4Frt58otYhiMiBU4IwNQOEsPbpJYqPbd5TIfjhzYmUJ5YBxdZVhyKHf6XzeFTWlXMwujJ9VySw1kmUBk7A/P/qD6NAxNANo9My/9Z1pk13tkWVLNb6vLiAZLH3uCbda3+b2l9lY78hG4=
Authentication-Results: huawei.com; dkim=none (message not signed)
 header.d=none;huawei.com; dmarc=none action=none header.from=oracle.com;
Received: from BYAPR10MB2999.namprd10.prod.outlook.com (2603:10b6:a03:85::27)
 by SJ0PR10MB4671.namprd10.prod.outlook.com (2603:10b6:a03:2d5::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4020.18; Wed, 14 Apr
 2021 18:14:39 +0000
Received: from BYAPR10MB2999.namprd10.prod.outlook.com
 ([fe80::50f2:e203:1cc5:d4f7]) by BYAPR10MB2999.namprd10.prod.outlook.com
 ([fe80::50f2:e203:1cc5:d4f7%7]) with mapi id 15.20.4020.022; Wed, 14 Apr 2021
 18:14:39 +0000
Date:   Wed, 14 Apr 2021 14:14:34 -0400
From:   Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
To:     Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc:     linux-cxl@vger.kernel.org, linux-pci@vger.kernel.org,
        Dan Williams <dan.j.williams@intel.com>,
        Bjorn Helgaas <helgaas@kernel.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Ben Widawsky <ben.widawsky@intel.com>,
        Chris Browy <cbrowy@avery-design.com>,
        linux-acpi@vger.kernel.org, alison.schofield@intel.com,
        vishal.l.verma@intel.com, ira.weiny@intel.com, linuxarm@huawei.com,
        Fangjian <f.fangjian@huawei.com>
Subject: Re: [RFC PATCH v2 3/4] cxl/mem: Add CDAT table reading from DOE
Message-ID: <YHcxChBDpxoopJT8@dhcp-10-154-113-106.vpn.oracle.com>
References: <20210413160159.935663-1-Jonathan.Cameron@huawei.com>
 <20210413160159.935663-4-Jonathan.Cameron@huawei.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210413160159.935663-4-Jonathan.Cameron@huawei.com>
X-Originating-IP: [138.3.200.42]
X-ClientProxiedBy: SJ0PR03CA0367.namprd03.prod.outlook.com
 (2603:10b6:a03:3a1::12) To BYAPR10MB2999.namprd10.prod.outlook.com
 (2603:10b6:a03:85::27)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from dhcp-10-154-113-106.vpn.oracle.com (138.3.200.42) by SJ0PR03CA0367.namprd03.prod.outlook.com (2603:10b6:a03:3a1::12) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4020.17 via Frontend Transport; Wed, 14 Apr 2021 18:14:37 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d95251b3-7f74-41f6-7b82-08d8ff712b2b
X-MS-TrafficTypeDiagnostic: SJ0PR10MB4671:
X-Microsoft-Antispam-PRVS: <SJ0PR10MB4671791863513E19A9B04C08894E9@SJ0PR10MB4671.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5797;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Pwbk0RjFebB531G6CLMJjImxZ8ddoM56xQxXHIoRCSRH835aKw/2FT6iRPbUbnmBTwDVFCECiVnQ3CbHtXCwNOYfro8CwddwoT33+RF3EkFRGsXA9g63S7zMPtDXWB1pW8rD5RihzI/Hm40vq+ZiGbTso5Fl2a+ErNpQBtLdFbuJdWtdnSsFNnrXdfihGoGfE27AGJMvsgTMZNnE4OF7v5c9SuF5DOO8yeOh2yrTsJoX08T3XMhpIEtpyTzDAmHAujlJkRroi4oFzXPB/Ovqf37tsldgjGfDpfVftVv0x/pDRBE8xElDA77IwTZqffRCg090/YVBHdiptmV7Q+9ItT/LvXBvd+Kd84/RWzQgNaSZWTS3gVW21bBT+nFFSCwDB2CRhwlyConfoomn4UuNSJpb859DKv21XE0Oxa5Xxmj2CjsBES5LDKMnHlJTXoEUZ3RDOYbROFMP7tWqK8ReukG6AagKis/T1RpjfmBDIf0QCQlXOHlNcwoykf1SAhAqjUUewnWZJlAGFEmNOxRVvT4pKyesaEqB2Jwi4O+Y1n8OzQyHMP8tpeWS9m46ef01WC3pZsM3ERTyK31KKl0evTuKmC/bzYpysI537N4tPOzPpj6LJJu7tQYLiFFV8Y7wiMAExkeqWLR+qlRxWaFmT97fgTRE4rOxwv8z5xpGJCp4BkCDw8iBz8HvJpYcaodW
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR10MB2999.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(346002)(136003)(366004)(376002)(396003)(39860400002)(7416002)(86362001)(66556008)(4326008)(8936002)(54906003)(6666004)(38350700002)(478600001)(316002)(16526019)(7696005)(38100700002)(55016002)(52116002)(26005)(956004)(5660300002)(8676002)(66946007)(66476007)(2906002)(6916009)(83380400001)(186003)(102196002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?I5SPle5AhJIyjcHb1ugUhdjOcAnHIK6fMLN4WvaZRnRGM9dCCdbjQ/aRy9fN?=
 =?us-ascii?Q?9hqXn9rSREUCtZ6ZcE5ch+RdPkng0qeZcqlD0nk0d6TlUiJ1n2R2drikg5N+?=
 =?us-ascii?Q?iA0LeZ/blT7m+w2nAMwXvxVVnyzMpEeq0gxZureonjXgfayS+FfH03lKwi2s?=
 =?us-ascii?Q?A/dtWzwF5KaMGkNR6bHBx2OM/1/zYJDwcW0rDKEpE9W7pbFITDxEvIOQwk9P?=
 =?us-ascii?Q?JP8YzBwpORZoTx8nQpeuxlcy4swHS5iTWGykd6QxG+56m0nb/VfmRTWDERlx?=
 =?us-ascii?Q?dlhGWqMIVR/cHPh4jJ/B5P5/f0ckukIR9/DBguJQkjNuDeAp1OZRF4564fd8?=
 =?us-ascii?Q?jH0fKHezdYDIRX8ULD2/Ufrs69sITgnCk51E9h5JV7Xr4bSBVeVxIKOAGofg?=
 =?us-ascii?Q?FlpP5ghmyLnizET/KF+TJfAtFr6rooAXRKAPSI3BnEJiCYlGcD57wJ63F4HW?=
 =?us-ascii?Q?NzDTgHizTcmKCDK5rCcWWPMLkBpHrJxd/rtQWaqCjZSYF3qYgb6XzBk43qab?=
 =?us-ascii?Q?oTKd0bW4EjV/7VkjmBehTE31auUke/JdEXQZaQtA2I+LoFQn1COTkX9t+HBa?=
 =?us-ascii?Q?uI9lfhQOcVoWbbN8Y8p1pZsVT9KJlmJ8PO5s8c6madKg3FqxfnWJXJ7Nnx+a?=
 =?us-ascii?Q?XWQJywLiZ0PeZnsLPsYPHAmxkQNHfw+9xEKUYI8McA4NmBbaszfN2ssanQP0?=
 =?us-ascii?Q?+wulvxCiTc0xWvLAreC3IGXgwQyDREesvibEIG74x88wdwkSdvWmOh8PWwVx?=
 =?us-ascii?Q?mgK0zc6H+jq4VjJxazcyVIq7BDG5+0dqcee/XtLxMAmCOXS/wExE3apjio+a?=
 =?us-ascii?Q?fDUfA4xA+fRMMvddTbTJAYGgYjITfyzvukLObE9Kb/QPl4EfLnp2ytO2k/aQ?=
 =?us-ascii?Q?X5tp9zQpZ+kzlOt//QRC2q516H/tFgmelt590OYUZt6/tcXxkeqbimRyQiVq?=
 =?us-ascii?Q?mZKNGHuw3HZb8xBFYAHj288V3QMidsrAUZt8K/lESbTb1kZAvWD1Z7MTlQ8l?=
 =?us-ascii?Q?5L/nDuBRf46TMIPIArO1SRCi4mbgXsOsGFnNA6/+6aLR1P4Jabg3cOW3xAAO?=
 =?us-ascii?Q?44kAfhH4Ci6CV9pZj4LDleBbsRpJZBf/+WrsLIIMOzRErjabdB2+yWotQsn0?=
 =?us-ascii?Q?Nw93/CB9M9OSsGcBU2z42jo5/e1hFKT0KpEV+bGWYvmlIsAI0WHHS6TzIKIp?=
 =?us-ascii?Q?NF4jtASmLJfi8QTaBR7pjF4W/aOzf/4umsROj1CTbuv6Jwjmvtjv+lVyBwFk?=
 =?us-ascii?Q?axFtnp4etmLyQZI7rYN53cyqFA6Ve0rU57sxjjnxR+CYgRz59spUmEc3h3mn?=
 =?us-ascii?Q?HR7+ff6835VUF+kNb2lq269W?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d95251b3-7f74-41f6-7b82-08d8ff712b2b
X-MS-Exchange-CrossTenant-AuthSource: BYAPR10MB2999.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Apr 2021 18:14:39.5091
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VEQHtcgliktEVh+H6bqJu+YRwyGVhGDs+X5BusUY/6z3S+m3NN+Xxu/Uns8bxNYw8tGVzghNPMAgpDimS2R/YQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB4671
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9954 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 adultscore=0
 malwarescore=0 suspectscore=0 bulkscore=0 mlxscore=0 spamscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104060000 definitions=main-2104140118
X-Proofpoint-ORIG-GUID: wksdFJSNhSz2fFbKKy85IMiKFsmBobt3
X-Proofpoint-GUID: wksdFJSNhSz2fFbKKy85IMiKFsmBobt3
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9954 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 malwarescore=0
 phishscore=0 suspectscore=0 mlxlogscore=999 priorityscore=1501
 clxscore=1011 lowpriorityscore=0 spamscore=0 impostorscore=0 bulkscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104060000 definitions=main-2104140118
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

> +static int cdat_to_buffer(struct pcie_doe *doe, u32 *buffer, size_t length)
> +{
> +	int entry_handle = 0;
> +	int rc;
> +
> +	do {
> +		u32 cdat_request_pl = CDAT_DOE_REQ(entry_handle);
> +		u32 cdat_response_pl[32];
> +		struct pcie_doe_exchange ex = {
> +			.vid = PCI_DVSEC_VENDOR_ID_CXL,
> +			.protocol = CXL_DOE_PROTOCOL_TABLE_ACCESS,
> +			.request_pl = &cdat_request_pl,
> +			.request_pl_sz = sizeof(cdat_request_pl),
> +			.response_pl = cdat_response_pl,
> +			.response_pl_sz = sizeof(cdat_response_pl),
> +		};
> +		size_t entry_dw;
> +		u32 *entry;
> +
> +		rc = pcie_doe_sync(doe, &ex);
> +		if (rc < 0)
> +			return rc;
> +
> +		entry = cdat_response_pl + 1;
> +		entry_dw = rc / sizeof(u32);

Could you >> 2?
> +		/* Skip Header */
> +		entry_dw -= 1;
> +		entry_dw = min(length / 4, entry_dw);

Ditto here on length?

Also should you double check that length is not greater than
sizeof(cdat_respone_pl)?

> +		memcpy(buffer, entry, entry_dw * sizeof(u32));
> +		length -= entry_dw * sizeof(u32);

Would it be just easier to convert length at the start to be >> 2
instead of this * and / ?


> +		buffer += entry_dw;
> +		entry_handle = FIELD_GET(CXL_DOE_TABLE_ACCESS_ENTRY_HANDLE, cdat_response_pl[0]);
> +
> +	} while (entry_handle != 0xFFFF);
> +
> +	return 0;
> +}
> +
