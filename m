Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D43A575C850
	for <lists+linux-pci@lfdr.de>; Fri, 21 Jul 2023 15:51:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231623AbjGUNvI (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 21 Jul 2023 09:51:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231560AbjGUNul (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 21 Jul 2023 09:50:41 -0400
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2048.outbound.protection.outlook.com [40.107.220.48])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68FE13A9B;
        Fri, 21 Jul 2023 06:50:27 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BD2EUeqT17D/MYsVwpR4LWc5BV156S35LGbMo0zPI0DKK9mcs0HCnr1MWAaY4hMPQmU8rhGO9LOp7ABdrqNmgBDA5IPCCUphrGF3xB3MB+J3iFfW18fWCQ2txQ8x6SUPbc+3ZzmeoZ0ULyHygNZY4rgOvR/OpikRTKNNKIY4POf3gbFKsVS0OIIkNMFM065J8Vm60XEclaqhUzb9NbOkIOuyG1tGkbRX6Ld40iDFseO5uQXct6dHqFF6W6+vbtLG1gr1WN+aWuAb26bjnxPsZ/70t9n8e/3yosiMZ+Wfwb75sXQMQljl42lE7nPjwZQtbcz3CpSyrNYYylDjnd3aYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mqvT1r04Vvw0F44AcQYj9uS/+hPfk0yViUimqB2sKvI=;
 b=ZNsogvh9q/jPPYMbrHIcee9azsZnmnn6HTGiIolLw2GaDf3eMBczwH2LWxfX6aZQmWUiKbEhNr9MmkxnQtKiJqRE6OLLr0wocrqGeLeIAP5WXCnfugZFTCBI0+8mb+l2eVLG/dmRnz8+fRl23wa3Uj8TP9IdLYB+1QeJAqsT/Sh9LMXAOQ52QJxkb98ZixmSG12VGofNdbKjvUdyUmF7OQ4vSTuWPt0unvF9Ntevmg7HQvHRHIY9Hnmb022kzvLdSfOBrbUFbMlIV7e4okfdqOdP1Ujx+mOICuac4FCOyKCCGkcyq/7mBOvEeS4BvbnVXluAmUPs9qd/Ck2aaUDPdw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mqvT1r04Vvw0F44AcQYj9uS/+hPfk0yViUimqB2sKvI=;
 b=MBAHKVdDwWOs+E6bd0Xpuse/iH02//hCPrD6bCRej7sNxZcMZNhk4mz4KzhBgn67eYfZC469wKF4SHqYawp4kU/y+MXhjBXqEMvlPbPus2jZx3Pb56nzYJOLz1v+X7xhTNj1BbMxAZNZK3FobJgCAe8erJGWdceKnQaRovmfhws=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB3657.namprd12.prod.outlook.com (2603:10b6:5:149::18)
 by IA1PR12MB6042.namprd12.prod.outlook.com (2603:10b6:208:3d6::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.28; Fri, 21 Jul
 2023 13:50:22 +0000
Received: from DM6PR12MB3657.namprd12.prod.outlook.com
 ([fe80::6cf0:e179:9f0b:edd9]) by DM6PR12MB3657.namprd12.prod.outlook.com
 ([fe80::6cf0:e179:9f0b:edd9%5]) with mapi id 15.20.6609.026; Fri, 21 Jul 2023
 13:50:22 +0000
Date:   Fri, 21 Jul 2023 15:49:50 +0200
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
Message-ID: <ZLqM/vi9lpXyNUQV@rric.localdomain>
References: <20230719192313.38591-1-Smita.KoralahalliChannabasappa@amd.com>
 <20230719192313.38591-3-Smita.KoralahalliChannabasappa@amd.com>
 <53d5eeb3-5a13-3663-57a1-e927c4c369b8@linux.intel.com>
 <937d872d-cbc1-3671-9c3d-ddceb9cb270b@amd.com>
 <ZLkxiZv3lWfazwVH@rric.localdomain>
 <fdadfe06-5d1e-978b-82bf-637a9ad9754a@amd.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fdadfe06-5d1e-978b-82bf-637a9ad9754a@amd.com>
X-ClientProxiedBy: FRYP281CA0007.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10::17)
 To DM6PR12MB3657.namprd12.prod.outlook.com (2603:10b6:5:149::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB3657:EE_|IA1PR12MB6042:EE_
X-MS-Office365-Filtering-Correlation-Id: 3bfe5bd3-f940-4174-b214-08db89f16d54
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: oPbGLyW1gMWUVDVbU/mswg04t1w625i/GLGFmKF6G0Djfzm+pqu25dGeiRnpmcb3D7DxtoBOSQE54cvg3IiKE8lt3wWnJbiWKdjLSxW7mdI6JNaRDNBuWZXPqoAoMTBwm/qBw/MJYKnNXLO28HG1QMODmzjOGGqXzWRYZYyJF4H6ESt5X5LwalkvU/KGPWcpoysw6IiYWoTAzRpcHUn+cOKfAmnwUjGYXt0zgJR4sS4iejQqTxd3rZZ9p24JmNCH17WyZ8ZrGfnEdfXKV/FlK36y9midI8uE8Xj9eOsDONExNjy+IQkQ8o+s+eE8xnp0gFW5oKDgK98lusxxS+EIuXIKiHo6gpdBWftulh7OhNcFU98+rL7HcL7wTvRjj7S0bWdVKUeOM7QRkwrySrJjFb7QoxnbG24Cln7NEW5H51PwB0fqxTRHjjtVZKWTcGn52alr57bb86F+GS/FIXsyhumZwANSEdnOxArTEEbWW31IH9woxn8fuqZO7x4IoUEXrTFXfWLoVOmA2wDj96N5GY4PUK0CPKr/ZaB5p3yo2+Wt3d0jWLwG3dRY+Z1LG99S
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB3657.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(39860400002)(136003)(396003)(346002)(376002)(451199021)(186003)(6506007)(478600001)(26005)(66476007)(66946007)(6636002)(4326008)(316002)(53546011)(41300700001)(66556008)(7416002)(6862004)(8936002)(8676002)(6666004)(54906003)(9686003)(6512007)(6486002)(5660300002)(83380400001)(2906002)(38100700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ksTLSpHucwycnL73aZOcqho3kXzYkuPMGPGJrFx/tjJFNoWAa3tL4WRgLGhQ?=
 =?us-ascii?Q?4aAe/CXryu1CuI8aDGJVRGHchELsL8+Scku6Bm3HLRLnNZ5+a8Ly2PyzVQl1?=
 =?us-ascii?Q?E67wW0CafNv/dea2J1yz4ImFiX2VuzhIos4Oe+3I14tzm6e2IUf+sUlHF2zK?=
 =?us-ascii?Q?+AzGKklZ4x2rCTvnmFZkucclhDut1LVXqt61x+sr+DcBIOHN+DyIpiE114OJ?=
 =?us-ascii?Q?aqrD1MsT1A7sCNdQMcEi/gSa682MQ3H24q8MCae2kqRinXT1OmVhOUOdOkBZ?=
 =?us-ascii?Q?hpWBciLghEXzgALKU9EofHmcnUPYxFxkSDuKFIaT4oW0Wp3DDGQC3r+n2MsN?=
 =?us-ascii?Q?ckJbtmYLj2srVIYQCgXC2h0AeGmT61HaR+nFtMNqoVycXKZDBeIbUn6TyOkH?=
 =?us-ascii?Q?KESUBUmuBUm+2ZjhpTpirNQOiUYS+3zEIFTH184GJQeirluWYyuK8Wd6rrPJ?=
 =?us-ascii?Q?cKXmZfEr/npD8807ogsawUN7oMS33KlPIa4w5ZwMTypp1HphptO2OXELGDig?=
 =?us-ascii?Q?JMqMsmUZTyvIR9/8TzuK2GwoR7JxbqUMcxsvsM1GjHPpypy9PJSIpLJYd0uB?=
 =?us-ascii?Q?7sP8on9mD6p8kE8/rR5fya+4i7siPe/JuGC8VhYhYecrGw5X6j1j9CA1ps1O?=
 =?us-ascii?Q?BtGzVltY5yfjW/N/CaFqdqz9lgW7cb8GjMSWTFxAQCqBG4aCWM3A68mmNk5V?=
 =?us-ascii?Q?cRlFFi6CKBs2yZKFaksUrinTykzmI7WOyUb5qCiF5lhAwMnvRpS1TIruqost?=
 =?us-ascii?Q?pYABSkh9ruy+rN5EwJk9U8HEBLvq0NtDZgz0oCn4Y1MjEo8HXRMSmuKkg738?=
 =?us-ascii?Q?FYVM3ZNDfFcFE7p3WIGTYacDDHxZxhqbsF/KB32BI0Q3Lhl6tTu/FWAOJS8N?=
 =?us-ascii?Q?ZjGC5ohfe47UG2jPWSQitL3l7M5pOUWLytSQ0qYCdy7eTJ3w+wSufwJhKb/x?=
 =?us-ascii?Q?7rrI8Vfz8d2ooksrZp9dTba+AyISFkLAz1dlwNPG+nImdtyptPSMggeaU/A5?=
 =?us-ascii?Q?68cabwy7bhHOvrrY0jq51R9nOD/mparVNG+5r4nXrQpRbaGqHdYGAl/WZfBf?=
 =?us-ascii?Q?d879FE58jnhmmju6O//3PuCfcjTEY9G/lG3eXC3prnNTyD8CQzBBp0i2lk5F?=
 =?us-ascii?Q?k+j0DYYRUmJTmK7s/aeR9D927PFgwWQyH9EZ9kn1gbZlaEcc2wTTbq7E1V+9?=
 =?us-ascii?Q?txmClITjLAAATcoiLpG4juQ1f3smqUWgLdAuWU3qAaI+0gmIIW/RtqgqYNYb?=
 =?us-ascii?Q?do+3m6Rm949+Y0ax/BPmf9Sbxxrs3x3YL4sTqW0wrg7cIDPEmW1yQHSc31uX?=
 =?us-ascii?Q?VEBTj+IV9omg9jm0LkKO8erz7IIxLeDU1VujauItvjRjm7XjVG2LDd9zFU9c?=
 =?us-ascii?Q?kB4Gp19yCbuYpcSujofQUIO1kYUB256tbAF+5Jf2yQK5UfA05X8l8rcoRCcp?=
 =?us-ascii?Q?paQTfDldreZY3HZ8XwcWMnlcC2sY5c1EiRo/PO4fpcN6MJeLN+AgQJDhS2Uz?=
 =?us-ascii?Q?+Vjas+zZW0lelJEEttv9ZowIIwKT6AqKWD9hGw5nvVFEofuY08WfPGzCs73X?=
 =?us-ascii?Q?jdBao1DvXOjunkur7B3oORrPN982WnESctNZROIW?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3bfe5bd3-f940-4174-b214-08db89f16d54
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3657.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jul 2023 13:50:22.1424
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WWmcbiLRHNhyRpDdplejWTlJ8ydW8yw4s16vxgzevXJfKW0/IWuTHz0ZZwZlmV268I19Wt+jjdInrCc5I9I4kw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6042
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 20.07.23 11:31:15, Smita Koralahalli wrote:
> On 7/20/2023 6:07 AM, Robert Richter wrote:
> > Smita,
> > 
> > On 19.07.23 15:30:25, Smita Koralahalli wrote:
> > > On 7/19/2023 1:39 PM, Sathyanarayanan Kuppuswamy wrote:
> > > > 
> > > > 
> > > > On 7/19/23 12:23 PM, Smita Koralahalli wrote:
> > > > > According to Section 9.17.2, Table 9-26 of CXL Specification [1], owner
> > > > > of AER should also own CXL Protocol Error Management as there is no
> > > > > explicit control of CXL Protocol error. And the CXL RAS Cap registers
> > > > > reported on Protocol errors should check for AER _OSC rather than CXL
> > > > > Memory Error Reporting Control _OSC.
> > > > > 
> > > > > The CXL Memory Error Reporting Control _OSC specifically highlights
> > > > > handling Memory Error Logging and Signaling Enhancements. These kinds of
> > > > > errors are reported through a device's mailbox and can be managed
> > > > > independently from CXL Protocol Errors.
> > > > 
> > > > Does it fix any issue? If yes, please include that in the commit log.
> > > 
> > > Yes, this fix actually makes Protocol Error handling independent of
> > > Component/Memory Error handling.
> > > 
> > > We observed that OS was not able to handle the protocol errors ("i.e unable
> > > to reference to the cxl device node") with native AER support. The reason
> > > being Memory/Component Error handling was under FW control.
> > > 
> > > Since the RAS registers are tied to protocol errors, I think there is no
> > > reason that memory error reporting being in fw control or os control should
> > > be a roadblock in handling RAS registers or accessing the cxl device node by
> > > OS.
> > > 
> > > > 
> > > > Since you are removing some change, maybe it needs Fixes: tag?
> > > 
> > > Missed this. Thanks!
> > > 
> > > Fixes: 248529edc86f ("cxl: add RAS status unmasking for CXL")
> > 
> > the fix must be isolated to this patch (for automated backports) and
> > you need to remove the dependency to the first patch then. So swap
> > them and ... see below.
> > 
> > > 
> > > Will include in v2.
> > > 
> > > Thanks,
> > > Smita
> > > 
> > > > > 
> > > > > [1] Compute Express Link (CXL) Specification, Revision 3.1, Aug 1 2022.
> > > > > 
> > > > > Signed-off-by: Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>
> > > > > ---
> > > > >    drivers/cxl/pci.c | 7 +++----
> > > > >    1 file changed, 3 insertions(+), 4 deletions(-)
> > > > > 
> > > > > diff --git a/drivers/cxl/pci.c b/drivers/cxl/pci.c
> > > > > index 1cb1494c28fe..44a21ab7add5 100644
> > > > > --- a/drivers/cxl/pci.c
> > > > > +++ b/drivers/cxl/pci.c
> > > > > @@ -529,7 +529,6 @@ static int cxl_pci_setup_regs(struct pci_dev *pdev, enum cxl_regloc_type type,
> > > > >    static int cxl_pci_ras_unmask(struct pci_dev *pdev)
> > > > >    {
> > > > > -	struct pci_host_bridge *host_bridge = pci_find_host_bridge(pdev->bus);
> > > > >    	struct cxl_dev_state *cxlds = pci_get_drvdata(pdev);
> > > > >    	void __iomem *addr;
> > > > >    	u32 orig_val, val, mask;
> > > > > @@ -541,9 +540,9 @@ static int cxl_pci_ras_unmask(struct pci_dev *pdev)
> > > > >    		return 0;
> > > > >    	}
> > > > > -	/* BIOS has CXL error control */
> > > > > -	if (!host_bridge->native_cxl_error)
> > 
> > For the fix, you could replace that with:
> > 
> > 	if (!host_bridge->native_aer) ...
> 
> Yeah I tried something like:
> +	if (!pdev->aer_cap &&
> +	    !(pcie_ports_native || host_bridge->native_aer))
> +		return 0;
> 
> But then pcie_ports_native needed to be exported as well. So better just
> keep the check to !host_bridge->native_aer and return zero in first patch,
> EXPORT to second and replacing host_bridge->native_aer with
> pcie_aer_is_native() in third?

Looks good.

Thanks,

-Robert

> 
> Thanks,
> Smita
> 
> > 
> > > > > -		return -ENXIO;
> > > > > +	/* BIOS has PCIe AER error control */
> > > > > +	if (!pcie_aer_is_native(pdev))
> > > > > +		return 0;
> > 
> > ... and replace it with this function here in the patch where
> > pcie_aer_is_native() is exported (or in a 3rd patch).
> > 
> > -Robert
> > 
> > > > >    	rc = pcie_capability_read_word(pdev, PCI_EXP_DEVCTL, &cap);
> > > > >    	if (rc)
> > > > 
> > > 
> 
