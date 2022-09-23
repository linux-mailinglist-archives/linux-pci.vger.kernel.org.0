Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E4035E7BCD
	for <lists+linux-pci@lfdr.de>; Fri, 23 Sep 2022 15:26:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232165AbiIWN0q (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 23 Sep 2022 09:26:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232404AbiIWN0T (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 23 Sep 2022 09:26:19 -0400
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2087.outbound.protection.outlook.com [40.107.237.87])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24B9B148A28;
        Fri, 23 Sep 2022 06:26:06 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RCuYaHot2Lc2pJueHn84S93VLNf6qYsAB2KLdaYWWP/CiI8dhMUsP7ru4W4ZZUKGwfFONDsgYfaQTWHJEDZrSSHEiPHjiXx1aJPTTLIVGpdsrBsqNnYmZImyF27Bgq5TI/ymw6DuMs5rRBRYMyZg/du9DDQbqOwJJiISvLecXm69x+6rl+GgaO+3nyvHAciXeY/K6awK5d+Eduenhtk59nZD9lacZjV4xMtYwxunpwwmaaTpQGR+92e9vj4YnLjJ7YpSbqJyl35K+DXfH+ykzCocEoXBwhC1EsHo1+3HN71vfpGbGW2er1BgxCeSdlkHSZZn2THqeAEBX+U46ajkpg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qq3em9at6q6sBzntYVGHAVrHzTB/pEulURtr3H65V2M=;
 b=aKRpI1i/C5vEO/1QiNWYLYEexr2Ql5tjxPxLGZLkNwAhPjvD2Th03kmLm0B8a2qjXRJRHqnq7gJv6GuOsa+jzlPMKfEQhUmFRO6M/UNUlrR/cP4lI1jJuNB+BaRVvwDDhObFyCKlRKcyq2316Hp0wHU0vTQH46uXRK2RZ1Iad6Z4BSLz/2VeAsFeiK705QN2tgUqQLfTN+f5NHIjFh8OjOC5iLe+QcnDa4ngG8Q4ezPv1rN/GmFjy2VfM04wgcRlQ2EetOgbgcGE+UFRhkakvmPTLKDnIcqG20HJqcu03RoHqxtl9vPwbMzm0N2BlvpoZ/3qTSMji/rPtc63lNvLUw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qq3em9at6q6sBzntYVGHAVrHzTB/pEulURtr3H65V2M=;
 b=LmEJzjxPPcIm+S4Gj+2j6lNB3LeRrZ7DQf5oBSSsLi5Wb4hFm/Sbi62EeUz3Pai1lXsBuJjg3+M3SUeYiaJ8NKyOT5/7Py2RJG6FIr3T1k2JNbeAyDu815wbmXb1gX3f2O5VX0xeCR3gEFZopDFCWngj0/TXZxnLzHUic6/I/FndseWtfkRRtRTil8eGCExZYv1SOWxz8z1ThMeByk9oZG8V2pv3jmy+1EZoZQ1pElXRy1vpa+bEaH7Gl7iuB/0XU3tPZmnbyZc53rTC17N3yADI+FKwDEetAfiirQZluAemciNjKp47fvE5G7jjnZ+XBNe6290Paxq2w5/UakZFeA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MN2PR12MB4192.namprd12.prod.outlook.com (2603:10b6:208:1d5::15)
 by SN7PR12MB7300.namprd12.prod.outlook.com (2603:10b6:806:298::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5654.20; Fri, 23 Sep
 2022 13:26:04 +0000
Received: from MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::462:7fe:f04f:d0d5]) by MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::462:7fe:f04f:d0d5%7]) with mapi id 15.20.5654.020; Fri, 23 Sep 2022
 13:26:03 +0000
Date:   Fri, 23 Sep 2022 10:26:02 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     "Tian, Kevin" <kevin.tian@intel.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        "Chatre, Reinette" <reinette.chatre@intel.com>,
        "Jiang, Dave" <dave.jiang@intel.com>,
        Logan Gunthorpe <logang@deltatee.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Bjorn Helgaas <helgaas@kernel.org>,
        Marc Zygnier <maz@kernel.org>,
        Alex Williamson <alex.williamson@redhat.com>,
        "Dey, Megha" <megha.dey@intel.com>,
        "Raj, Ashok" <ashok.raj@intel.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jon Mason <jdmason@kudzu.us>, Allen Hubbe <allenbh@gmail.com>,
        "linux-ntb@googlegroups.com" <linux-ntb@googlegroups.com>,
        "linux-s390@vger.kernel.org" <linux-s390@vger.kernel.org>,
        Heiko Carstens <hca@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        "x86@kernel.org" <x86@kernel.org>, "Rodel, Jorg" <jroedel@suse.de>,
        "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>
Subject: Re: [patch 21/32] NTB/msi: Convert to msi_on_each_desc()
Message-ID: <Yy2z6p8g3248gqLA@nvidia.com>
References: <875yrvwavf.ffs@tglx>
 <BL1PR11MB5271326D39DAB692F07587768C739@BL1PR11MB5271.namprd11.prod.outlook.com>
 <87fsqxv8zf.ffs@tglx>
 <BN9PR11MB5276961D838169BF237928E18C499@BN9PR11MB5276.namprd11.prod.outlook.com>
 <YynJqID/E5dFCakg@nvidia.com>
 <BN9PR11MB5276CAB439EE27557FC17B1A8C4F9@BN9PR11MB5276.namprd11.prod.outlook.com>
 <YysIEUbxjS328TAX@nvidia.com>
 <BN9PR11MB52768936DF8C7F19D5997A0C8C4E9@BN9PR11MB5276.namprd11.prod.outlook.com>
 <YyxRf0UEEyT79oE5@nvidia.com>
 <BN9PR11MB5276D6337528F356B44F18498C4E9@BN9PR11MB5276.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <BN9PR11MB5276D6337528F356B44F18498C4E9@BN9PR11MB5276.namprd11.prod.outlook.com>
X-ClientProxiedBy: MN2PR03CA0021.namprd03.prod.outlook.com
 (2603:10b6:208:23a::26) To MN2PR12MB4192.namprd12.prod.outlook.com
 (2603:10b6:208:1d5::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR12MB4192:EE_|SN7PR12MB7300:EE_
X-MS-Office365-Filtering-Correlation-Id: 759b16a1-f22e-446d-44ca-08da9d6729e2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: NJkA3gd3kESrnq2UcZAi1ucGAj88CzGtVDGBbGX+diaZAUO6KX5S2qOzyBJizkHk4DHKuZo78Rd8A0sdQQfKYZsP3rRpinCk2oR6erYTp1JH7yfdLiRe10T6jAhPc4b0J3JsbnvY0pmj7H7NRqKUQtH/5flxS0jElurMHwtZSwBTbgdw1gCT9CY+bziOxc7SnxBMMsA9xw1Ss/l+V8r6Irl8E1h6r5U7RLmtR6T8cFRXaEFqzPv1P8XRi13tZ+MBJhLWKJkBgqCazqDuWBnS5luWO06HkRroP6KuzKMb6isoST7UjDY69LzpNjOR8+RA2FgMr5GWb6rcPavMckr3Mo8MGlTcydVj+cztninsK+t+olF0OqO2TELGD7D7NuORW/C7EOjzfQDNzr33ba5Dzyh7HQzHSTmF/boV02xq48cruC++9aTnFfFBCl+wxO38/vVFwQ1xLKOx+VNtGA/2Q84m2ra6mF0k3WZHmsqY+nixaCAYf3z4fc1tJMWP7QuGGBCs8Nb6tYR4lCWClGHkLckzDb5mvGN9CpnEMb/UR7orU4HI++V2qHW/8IA0yhDL4/DPa7W8xJrSgmFoHwoB+Bcxk4LUKGLs3yZhUEO+C489Bz0YTdgwBPA09/MHhADS8WeW3VNVL3nwX+slC+hJkb3HiKLzZn356pp3HO/u3lrH8IWHs2oHw8VUXTber8HM
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB4192.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(376002)(136003)(366004)(396003)(346002)(39860400002)(451199015)(66899012)(6512007)(6486002)(6916009)(36756003)(316002)(66946007)(66556008)(66476007)(8676002)(86362001)(6506007)(26005)(8936002)(41300700001)(4326008)(83380400001)(38100700002)(5660300002)(54906003)(7416002)(186003)(478600001)(2616005)(2906002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ZNNraHe/ZQqTgXC/fbVP9mDDWmYI0IeHigKgdJr0Swr30ev3Kz5lWTYKNJvs?=
 =?us-ascii?Q?d3VcD74/xqOPzkJM4naXtwAqe8xuh2xLARcwzGPUbeKdBs04zCNxK4qH+mWH?=
 =?us-ascii?Q?JGXG7DgOyskD2NzcJNtAaQgBp4DKYn7KwJsVwCwOl4aZrGgLXo6xrIWoGgwa?=
 =?us-ascii?Q?8c/xxAkwTabtcifSRvoUKG8dS6w8/c8rlyNTkPkU/7oAikIaNnFRCcbwAX/h?=
 =?us-ascii?Q?kXv5gREc/Yay8JdJnb5wBzwmGorDGEtXZpCKrc99+uC5IrWVqnKn0xCvAlmp?=
 =?us-ascii?Q?QrRWpGWFYwrOCM/RfjSOZWPVuhez31Vy1UguI2Id5F9hrDVcJlqPiiBe++vW?=
 =?us-ascii?Q?eCXegitrtDO+9EFxUCy/+FXC70o6RdsV7PZxWIt/qM9QHs4eJQ0EXcSy2VEa?=
 =?us-ascii?Q?4aY5WB357HVQuqupTIh+m/JfATNp1W6jcwKo+WunVvnKfXVcq4Ssks1sL9ra?=
 =?us-ascii?Q?XVMolEcAJ1rMhHEBwxsUcnfVi8Em+SIH0xOSEQYCRafFk0uTfcz/ceLpukQG?=
 =?us-ascii?Q?M3NesqPClhVw2DnVJeHCTANOHj/vlabbA5ngtc+RblWYNlrdvEGs978tp51K?=
 =?us-ascii?Q?kweaX7B5tVWebdsC4SVm3MhwSYvys32Xsh7MNfQMOS/3ysCnDRWLtGO5mGgb?=
 =?us-ascii?Q?rfNDOShGgV39k76oYJEyrUaJsCcg1vPtQ04BfIhY3bRDJK1QqNtOxDDGlnPI?=
 =?us-ascii?Q?pV61ONTNuD2/aItpRuk+unrwmxKWantrVky8jXCb3Ll0prJcQrm1sWjRQnmR?=
 =?us-ascii?Q?Sxt5AQKEHYwoXyzEnxeKNOL/xyzUhj+AjA5ikj6K0Fn4cjWcnCUMqpxMzggK?=
 =?us-ascii?Q?gyqY9p6Uj7Cp+vGo8/W+/ovDxIDIt0bjg4PAEkT+ELAqfJynWKZOIfNwjSJ9?=
 =?us-ascii?Q?lG8X+30TWEauUMTzBmbX3Dn5ao0VzfR3h8KvcIMjtwhMJyDaW0q9g40iq9NH?=
 =?us-ascii?Q?e0zkehFa4OziiD7NsxIlNifxd2m7AWJ3mv1QAuAbmRRE5AMuAqK8MK7fWEFS?=
 =?us-ascii?Q?6ltQZe4FQkVbLCk6sH0G+SUuzfgjIkOXVaBtpskra0J1CWpdnTCAY70eEdyn?=
 =?us-ascii?Q?vE4k7/DcykLd4t8UJyvbO6ExqzNs7qPCj0rk1YY3DDbe299I8ZWP6QHWKO2d?=
 =?us-ascii?Q?Zno8e9HBd9TT4BRZqx5XLtqpZbpeHCU/eujndZhx5NHyRTscCrHXSet9TR45?=
 =?us-ascii?Q?MWUVIH3Vya5moC8FoCis+5FDImTIwkkZtQ/EuKThywfo/SY74p7NOctgUvxs?=
 =?us-ascii?Q?D4CQ90+IBRdDGFRWIHtHXbNNRNUBDjjiT3tLb7w/REJTChAvJJsJQxd5YIay?=
 =?us-ascii?Q?gJbkHZZrLGWYgLEwl1dh9PwCulvJ+l3/xLXK1t0LWeAKklQNzCeB+3yj3A/x?=
 =?us-ascii?Q?UZmx3Hy4+NJ8A6xNdoDQedQtgA+HFYI2OcjcnISV4hQuUIQmSsri3bFZ7i7l?=
 =?us-ascii?Q?LeaK2ueHIhSL4EexBVkHUEEP/o8RxmtFUtun+Zgm1zUtaglVUvxPi21KYCIo?=
 =?us-ascii?Q?CF/qg6JPJaRfmchq98DTXZgCtPU7hWaQHL1q2B8Ls4tDbU4H4uJXWWOYb4fg?=
 =?us-ascii?Q?JPyE7a5CpzVbztSkwSfenJnluQ8Rn9xONrUScsqo?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 759b16a1-f22e-446d-44ca-08da9d6729e2
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4192.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Sep 2022 13:26:03.8889
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EGrarUxcSLKPM+2u8RrsbSc+eFSo0vzFaCX6JuvXzjoGdnL5l6bs9egPIA+0RlxQ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7300
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Sep 22, 2022 at 10:42:46PM +0000, Tian, Kevin wrote:
> > From: Jason Gunthorpe <jgg@nvidia.com>
> > Sent: Thursday, September 22, 2022 8:14 PM
> > 
> > On Thu, Sep 22, 2022 at 05:11:00AM +0000, Tian, Kevin wrote:
> > 
> > > > Thinking of the interrupt routing as a host resource is the problem -
> > > > it is a device resource and just like PASID the ideal design would
> > > > have each RID have its own stable numberspace scoped within it. The
> > > > entire RID and all its stable numberspace would be copied over.
> > > >
> > >
> > > Unfortunately it is not the case at least on Intel VT-d. The interrupt
> > > remapping table is per VT-d instead of per RID.
> > 
> > Doesn't that just turn it into a SW problem how it manages it?
> > 
> 
> When IRTEs are shared cross RID's I'm not sure how to make the
> allocation stable between the src and the dest. They are allocated
> dynamically and hierarchically in request_irq().

So I suppose the issue is labeling, and we can't standardize where in
the shared space each RID will fall, and the HW can't virtualize this
for us.

Maybe the answer is that IMS just isn't supported on this HW if live
migration is also turned on.

Jason
