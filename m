Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9260875AF2E
	for <lists+linux-pci@lfdr.de>; Thu, 20 Jul 2023 15:08:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230481AbjGTNIO (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 20 Jul 2023 09:08:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229535AbjGTNIN (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 20 Jul 2023 09:08:13 -0400
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2058.outbound.protection.outlook.com [40.107.220.58])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C0E1FC;
        Thu, 20 Jul 2023 06:08:12 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Hmh9m9CB0xupJJrlCt3Y7oETDVMKVs9cZkYzMpce7BwLxRaVbTTY4O7I8AIY8e6owEx9K6k1oWoxBpsIOz63m8VDvZaReSGG5Aqw0gjokcQ47VDMPyIx4arAmcZgp7vqzJzh2C1760HP0e1itUfgvWZELVFKa/AJLE2udkTrDB7X/p8pqlst23RRbarn/esE3CqOufZ1+7uflbH43T7ZSY25GECxy7HG7oAKxrGy0f4tjnOEtttCriDPL2hKrp55qxkdWT8hNKDshAimWp6mWAOHf9PKR6EeXsdkGlO9ImjHTUxxv4aX5Hr0CL/r/tnIZJ0ErfTuCiU1RlReV9AmuQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=M7zZWXsY9tGcE3Nk1EXzJMLFh1oVHk73F8ju+sqLf2o=;
 b=lwUJfQ+6u8L20Zp7S0gSAyFMx2gJN4EgPR0tyujYP6vSXvPE9cvW1kruz+ZEg8d60IW04NS/NJ+ooRtTsYXcPT6osX/Ld4WIXnXQDAUXGnAbMwAUOAKQVy3ytpsFWXa7x6WuEr/T4pvdcIGFtyjD8ZGtT6qeMTrKVhIHuV9zsD8Jj4j2b+jyELJgzN2CGwRGGtGTPN9YNE8LHN3jx8znxKxigVPu663yX37RTvmNNaSAlzOFKdMpNyWElZxYCS0AqQpDVMuHIyLzqkdDqBtb3ZinkNSelv+bcNLzF62vlCUwY/8a8J5VBBn8woYlBTlT0Ale0FswCdIUuYfNACHcYA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=M7zZWXsY9tGcE3Nk1EXzJMLFh1oVHk73F8ju+sqLf2o=;
 b=2AsqnWR4wx4uyQERslIE6A9CaKp7W2gKUcg1Ed8w7fl05mduS9/r+jIUrTsAdM6lRi6//J/cqBZnSkhxV6lYBc/h1kxxBOhbnHrQ/KFzT06pq0r5vxRxslq/2FY4CHSjWnWNMpQjusVQQz5DbZ0rD8iramxdVaMwKNcslAmmpd0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB3657.namprd12.prod.outlook.com (2603:10b6:5:149::18)
 by MW4PR12MB6950.namprd12.prod.outlook.com (2603:10b6:303:207::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.32; Thu, 20 Jul
 2023 13:08:10 +0000
Received: from DM6PR12MB3657.namprd12.prod.outlook.com
 ([fe80::5e16:42d5:bece:b827]) by DM6PR12MB3657.namprd12.prod.outlook.com
 ([fe80::5e16:42d5:bece:b827%4]) with mapi id 15.20.6588.031; Thu, 20 Jul 2023
 13:08:09 +0000
Date:   Thu, 20 Jul 2023 15:07:21 +0200
From:   Robert Richter <rrichter@amd.com>
To:     Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>
Cc:     Sathyanarayanan Kuppuswamy 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-cxl@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
        oohall@gmail.com, Lukas Wunner <lukas@wunner.de>,
        Mahesh J Salgaonkar <mahesh@linux.ibm.com>,
        Alison Schofield <alison.schofield@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Ben Widawsky <bwidawsk@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Yazen Ghannam <yazen.ghannam@amd.com>,
        Terry Bowman <terry.bowman@amd.com>
Subject: Re: [PATCH 2/2] cxl/pci: Fix appropriate checking for _OSC while
 handling CXL RAS registers
Message-ID: <ZLkxiZv3lWfazwVH@rric.localdomain>
References: <20230719192313.38591-1-Smita.KoralahalliChannabasappa@amd.com>
 <20230719192313.38591-3-Smita.KoralahalliChannabasappa@amd.com>
 <53d5eeb3-5a13-3663-57a1-e927c4c369b8@linux.intel.com>
 <937d872d-cbc1-3671-9c3d-ddceb9cb270b@amd.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <937d872d-cbc1-3671-9c3d-ddceb9cb270b@amd.com>
X-ClientProxiedBy: FR2P281CA0171.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:99::16) To DM6PR12MB3657.namprd12.prod.outlook.com
 (2603:10b6:5:149::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB3657:EE_|MW4PR12MB6950:EE_
X-MS-Office365-Filtering-Correlation-Id: 18f1820c-f5da-4afc-d03c-08db89225d7f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 6EE0NIG656kHmuJvjr9nx+l6bOh9moljuftGZSfcF6D1QEUenSEyGT1PYYc7ISYpTZu7nKBEql6rAcPXSAqGZSDMXqe/oPrMyf14fUo1eCdEc3hqz+mExGXHnllL/vEMv2TERJU49qChJhKvjjg8457+4I7fKep63k1CQ6yDNq+7fCEZjKhfkw50GFL4I1Cm544wE/6MxWQWWNkOnHDsVpr6lr/IzeJedDCKT4ozHUhYoH/s3XU54iYBqYOfBTRXYx4GLexCX4RRjFAsXUleuuwlI4ZqykixSzUIj0G6ZgIl7VfCuntHPzi0mCs2gLS97Y5ih75ZCLMZG1mBZ2u+GsDFWABD0qasfKpr5ucmrnt+MN/wgRgVRZAfHRQDNczr0XajQRk/fWTVtpnGgNN++VaAMIupvW48iLGE25QLBR4YLtNKl7A9aNPIX0YzsMnrfSiGt/coEcbHSjpL0jscMlgcP+bz+sJO/TShfhgddeFld3tqDPMYMQoXdonETFE/IJ1jRb52TgP4oaB/PuYQTWo1nwoSe8YwAZHXMw7XlsL7LiTOr2IU78NlgArjbzNA
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB3657.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(366004)(396003)(136003)(346002)(376002)(451199021)(53546011)(54906003)(478600001)(186003)(6506007)(26005)(6512007)(6486002)(6666004)(83380400001)(9686003)(5660300002)(41300700001)(38100700002)(6862004)(7416002)(8676002)(4326008)(316002)(6636002)(8936002)(2906002)(66946007)(66556008)(66476007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?uX0StJpgBUlgbMJKnHAdRhaugpRdO2RBvAbhqNaxk/QS9UQX3eHogD/v9wrb?=
 =?us-ascii?Q?RlDhHanAL9gwAsPPGgP8+BNI/Zec0hkdLboLCcAXFDJjvTf92Bhzu7cBaArd?=
 =?us-ascii?Q?SXKulXD3OafCAO/6w4FnfrGSScpwB1W60ToztJ0GY8QZWGnXuGt8JUESsrd4?=
 =?us-ascii?Q?ceYBaDw5m5VkImpp4PCCasovDQS2vgnFrbkRfEKeMwPd4Vd7W0UmrVAyTTlI?=
 =?us-ascii?Q?t2v3wlbQhMEH+TKzqs+JWS5WJ+P+OcnhGYAWuCTuZV3c/gRFuj2zLOBdm8w5?=
 =?us-ascii?Q?MMjX5s0zOAKG8mXdoIEp9W1EdlUxwVosXF19OXUsOQ5LNBzdh/JZAaJKMwf5?=
 =?us-ascii?Q?XXkw3Tzp//Ttm9cOwaNnNBuSql8fkRc7Src+H6jJDWB+miNiMiB9KU1/Fu1I?=
 =?us-ascii?Q?FCYYEUEr7qVvX67mKzd6jcWw1V4/rzlvXzNP6h9ms6ACGLUcSlKyOiwy25pl?=
 =?us-ascii?Q?+/MW0j8YUV0d3c4FzWs20JGG7Nfokrje9uzFH7VIaIhozo3I7na+GKAErord?=
 =?us-ascii?Q?5k4E1Q7xog9tGqocKR0KA2a0rr4PjvfxU8PJZoddREhEs15b+GrH5t4zBzBS?=
 =?us-ascii?Q?DYnw3Ht2iZMsbWWerw2httd9JjgdHYc/pJyROlL/QKJhYtM0WOfJ+oWIgae/?=
 =?us-ascii?Q?34d51F6L34ShKiaxTjDqg+quyb9+Zo6vaxVhxg9J1UveL/QzCgcyAA8Nr3qB?=
 =?us-ascii?Q?4u5ZjPNreYKUtKovCbXEDxi/BiTojagk90PRJwdtRb1oHFC/gJZBSzo5Pq03?=
 =?us-ascii?Q?yzmRm4bQfMEGS4sxpMtJRzhPNMWJqgc/fb4hlbUbnjVR0SXgo12e5ton6UPe?=
 =?us-ascii?Q?zObSdhd1hS7Jfv+vLKSITUu18e30cmVzLlhfO8dX4Fn7/hVDQffx+/BqNTSr?=
 =?us-ascii?Q?+Enbe1vqtqiU/GPx40yehCOpy+mIaZ72GoTH738akV/3xWnpbhEKFpAa26m+?=
 =?us-ascii?Q?EE09vqijLuuF+cFKnWm7dKVUWLjyYDJIb78gKqIGPKhqzhX2iWrSQF8tJjD0?=
 =?us-ascii?Q?bUOlvZA2e3mmQeEdOlVlfGb7sRIrt8f6VyyWfMg4EtNlsWO385csfNAYgRxg?=
 =?us-ascii?Q?ElZnwNQJEvBubKZfds7WxAq3ViWsCe70sacNLdvCKovfk0QYOUfZPz4TKOAZ?=
 =?us-ascii?Q?naTVeEW9OWaslDp1gEIvZbMmRBJe+G7jOm10PiCaXutGQWFcx0nEAA/I7TrO?=
 =?us-ascii?Q?OJXY7lWHBfbOXWjf0UxgZA485boea3FO4lxMSspQfCMEoJBcZR+WGgntNDp8?=
 =?us-ascii?Q?g/8IX0Ax1vPrqDZVlcD37PGHdydqCkgZYx2UpVERS4qeQ2lW3PbK1INmlFZT?=
 =?us-ascii?Q?j4nJvc/WS+WwTBAKhE6r5esfHUzRq0EQdGOtYMeevnFr8DWVKRADq4YZlfiQ?=
 =?us-ascii?Q?bTOktLCi2PpqOt5q+/099wSK2qVlCfJDGW4bAyM0jFUFGCy4N4k4vFBuAAvU?=
 =?us-ascii?Q?cgZGdupGz76Byet9D6jQ8M9kaWwCtPVz1K61JLxhGI5V/0t1K5GTSoqVqI87?=
 =?us-ascii?Q?GRHaDROQcCq1wZ+vEs7NwtrKjvVh7pxyhNrwkWcTsfd9VBD6yor2NHI61bb2?=
 =?us-ascii?Q?W0ZuzXnPYqH2/5J5QzCsB9NL54DnUAblJhDqcjla?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 18f1820c-f5da-4afc-d03c-08db89225d7f
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3657.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jul 2023 13:08:09.5543
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7SIFVGsOEGplKYfziuonMb5BHNVrRae9yxPNG9Xkx1438pq7DtXz61Jqmg0h/da2yDoYM7u0mckNo0NSrMizig==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB6950
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Smita,

On 19.07.23 15:30:25, Smita Koralahalli wrote:
> On 7/19/2023 1:39 PM, Sathyanarayanan Kuppuswamy wrote:
> > 
> > 
> > On 7/19/23 12:23 PM, Smita Koralahalli wrote:
> > > According to Section 9.17.2, Table 9-26 of CXL Specification [1], owner
> > > of AER should also own CXL Protocol Error Management as there is no
> > > explicit control of CXL Protocol error. And the CXL RAS Cap registers
> > > reported on Protocol errors should check for AER _OSC rather than CXL
> > > Memory Error Reporting Control _OSC.
> > > 
> > > The CXL Memory Error Reporting Control _OSC specifically highlights
> > > handling Memory Error Logging and Signaling Enhancements. These kinds of
> > > errors are reported through a device's mailbox and can be managed
> > > independently from CXL Protocol Errors.
> > 
> > Does it fix any issue? If yes, please include that in the commit log.
> 
> Yes, this fix actually makes Protocol Error handling independent of
> Component/Memory Error handling.
> 
> We observed that OS was not able to handle the protocol errors ("i.e unable
> to reference to the cxl device node") with native AER support. The reason
> being Memory/Component Error handling was under FW control.
> 
> Since the RAS registers are tied to protocol errors, I think there is no
> reason that memory error reporting being in fw control or os control should
> be a roadblock in handling RAS registers or accessing the cxl device node by
> OS.
> 
> > 
> > Since you are removing some change, maybe it needs Fixes: tag?
> 
> Missed this. Thanks!
> 
> Fixes: 248529edc86f ("cxl: add RAS status unmasking for CXL")

the fix must be isolated to this patch (for automated backports) and
you need to remove the dependency to the first patch then. So swap
them and ... see below.

> 
> Will include in v2.
> 
> Thanks,
> Smita
> 
> > > 
> > > [1] Compute Express Link (CXL) Specification, Revision 3.1, Aug 1 2022.
> > > 
> > > Signed-off-by: Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>
> > > ---
> > >   drivers/cxl/pci.c | 7 +++----
> > >   1 file changed, 3 insertions(+), 4 deletions(-)
> > > 
> > > diff --git a/drivers/cxl/pci.c b/drivers/cxl/pci.c
> > > index 1cb1494c28fe..44a21ab7add5 100644
> > > --- a/drivers/cxl/pci.c
> > > +++ b/drivers/cxl/pci.c
> > > @@ -529,7 +529,6 @@ static int cxl_pci_setup_regs(struct pci_dev *pdev, enum cxl_regloc_type type,
> > >   static int cxl_pci_ras_unmask(struct pci_dev *pdev)
> > >   {
> > > -	struct pci_host_bridge *host_bridge = pci_find_host_bridge(pdev->bus);
> > >   	struct cxl_dev_state *cxlds = pci_get_drvdata(pdev);
> > >   	void __iomem *addr;
> > >   	u32 orig_val, val, mask;
> > > @@ -541,9 +540,9 @@ static int cxl_pci_ras_unmask(struct pci_dev *pdev)
> > >   		return 0;
> > >   	}
> > > -	/* BIOS has CXL error control */
> > > -	if (!host_bridge->native_cxl_error)

For the fix, you could replace that with:

	if (!host_bridge->native_aer) ...

> > > -		return -ENXIO;
> > > +	/* BIOS has PCIe AER error control */
> > > +	if (!pcie_aer_is_native(pdev))
> > > +		return 0;

... and replace it with this function here in the patch where
pcie_aer_is_native() is exported (or in a 3rd patch).

-Robert

> > >   	rc = pcie_capability_read_word(pdev, PCI_EXP_DEVCTL, &cap);
> > >   	if (rc)
> > 
> 
