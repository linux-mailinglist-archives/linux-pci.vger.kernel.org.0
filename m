Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0BB414ECD0D
	for <lists+linux-pci@lfdr.de>; Wed, 30 Mar 2022 21:12:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350695AbiC3TOI (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 30 Mar 2022 15:14:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351599AbiC3TNq (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 30 Mar 2022 15:13:46 -0400
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2061.outbound.protection.outlook.com [40.107.244.61])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A3D113F5D;
        Wed, 30 Mar 2022 12:11:49 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=J2uzLxSNzcKQsSPOcP1SQadyYP108Vx6LbOmWSiN2sTIZyrzs4aiKpVSR4dfyomn0EHg8j1zYbLV/RmZVukTQwhiY5BmIpSZAP7NL17PuwAj3lUICSf+M0BEx6C/PsyqmSVsVU2roKjbZgFg3ahKOzoq137HUW9IUD320TN6E8UvnavGNQwPaVgQ9lcfhGyOFAsczE3h0JFsHy2bT9pEszjFiAsQFD1H8Pn7V/hJPrYIVyBs1trPDLphMnawKKIMeeazPomdkwGTewFK3leV09aYwGe/ZdjwkqCi+knjTqAIhGhfN9ba4YtJZ4NyR8Rqlqv3QkU32s2fx12lmOUaSg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oel8KlLq9Puvl6SCBH1hOrw6Ylcc4lWW/FAvVt1MIMM=;
 b=BiiHU4lAM71lGiryOAgySeoVEceTsv2UjjDM+QsPnWwpBw1b7ud9rtdlzZcJK8mPxYH/VMGTag7s2E0fKgFtvoI0N2+vNVAGcfrIU0pXfqMtWDUYG3E9dQFZ1H/2cmUdZL7zzd5CQW6yec8i7J9COnROPEO8Y61oJKmTcLfCsxyOR4k1GZCOyhGfMDDPZSVLvrLP6VVcXCZDN9KYTialy2V8uuJv1tlAm28YzYGI6Y/PRd/u9Q2y8j/l2a6LUWH3/SWEpVpg/1E+uZoeT4ZgwJC9vJllGAJlgkaF1wPcfC6RHjSGS9zfpg3ykOS8EEXQkz7tiH9NTAqq4FFOWhXHvQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oel8KlLq9Puvl6SCBH1hOrw6Ylcc4lWW/FAvVt1MIMM=;
 b=IOqDBgCznuu4Q7htJz4p2okhCug3QlM9Ua3bir/J3HB8nEbegv58GzeshDtQeBvjZ4QRgPNBZH6329DsA4FFoEHtu00kfNkJ9GGK25RIatXoNPJDou7TMcjOz65l4Pdiwqm36F52iY8EvzGcGFKSlpdul+crVt4ltNy3iAOdSNPN6bPE1EXgCLGkWwLUN9KzJHMT5qLoOi7bjj3SKpvH0lqvLIkPOtZ7AInEF0nkt8Ucw4jOGDntfwmBkxjltgvKmshhiki0TOa4I2EGOO1pzEPX2yU3KbGmviV+kh4OItPvIiCxrASNaXlasn4WllqN3Ass5MTjn9DNFVptVQXh6Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MN2PR12MB4192.namprd12.prod.outlook.com (2603:10b6:208:1d5::15)
 by MWHPR12MB1405.namprd12.prod.outlook.com (2603:10b6:300:13::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5102.19; Wed, 30 Mar
 2022 19:11:46 +0000
Received: from MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::11a0:970a:4c24:c70c]) by MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::11a0:970a:4c24:c70c%6]) with mapi id 15.20.5102.027; Wed, 30 Mar 2022
 19:11:46 +0000
Date:   Wed, 30 Mar 2022 16:11:45 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Shlomo Pongratz <shlomopongratz@gmail.com>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        andrew.maier@eideticom.com, logang@deltatee.com,
        bhelgaas@google.com, Shlomo Pongratz <shlomop@pliops.com>
Subject: Re: [PATCH V4 1/1] Intel Sky Lake-E host root ports check.
Message-ID: <20220330191145.GE2120790@nvidia.com>
References: <20220330153720.GF1716663@nvidia.com>
 <20220330191017.GA1700536@bhelgaas>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220330191017.GA1700536@bhelgaas>
X-ClientProxiedBy: BL0PR02CA0012.namprd02.prod.outlook.com
 (2603:10b6:207:3c::25) To MN2PR12MB4192.namprd12.prod.outlook.com
 (2603:10b6:208:1d5::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f9e54a1a-e93b-40e3-7766-08da12812288
X-MS-TrafficTypeDiagnostic: MWHPR12MB1405:EE_
X-Microsoft-Antispam-PRVS: <MWHPR12MB1405DA586B201058F1785D07C21F9@MWHPR12MB1405.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: dQF7uj9t3T55oq43XSYucxFtE4JCJK7Pk/ZMDNOzDMPbUBw9COY4/N2GC8OwofOxWFgxcUjVyqJGI86yr+xCOfmf3DjEOQRIv/8EREd7gMCj9eFFuz/WlUzEzeUIrmoquYJWesl5QAAsioXhdhipVe8a8C7pqiKyY08tvmagWeI0CmgRoIB1W1BjBGV83+SZiQcX57QAK342h11Kaqj3g9dQOwfFfngMdM52qPbv1nDtMzMPaiJdnLD1PZHRDTVza9CN0ZEe36KxgRE18hS76j/hE07m66Zk7WxgizDGhREIofa5x3p/Z5go2ytLt4o3J6RLZb4hKGKaYxukj1iF6HJbdgwGqRNkuzskNKlXyQpHkG2FJ7V7jOaRdSeJE9FrRhouLdesXcwUsEiJTbPXskzUOZq1jguK6qabpUtPmmTFcNMW2nwOMBzLRg873jYxqBwu3wB0TozzmVlGkDnKsMNPHpJU1KpvPVAF9HCJI8arqHxrF0j+MG3fAozjJsbFJdZWbNgIfu+xf9MyohICYhj0Qe0OqbPzPbIBjRKuObsR2/ItUM0joJN+fNAdwjyXLjBaal5eIGK9xb4dVHV9NJPKDpuD/hJ82G3qmDY+w82RaKdhL+3xUu2dAeYa1bmL4T0lF5JAs3IyYuEOIYzOZw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB4192.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(1076003)(4744005)(316002)(6506007)(2906002)(36756003)(186003)(66476007)(66556008)(5660300002)(66946007)(86362001)(4326008)(2616005)(8676002)(6916009)(508600001)(26005)(54906003)(38100700002)(8936002)(6512007)(33656002)(6486002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?4NhcLP18lkgx2yuHaWSxq2GXzU8ejaN3V5Q241W3x+IRL89VxPf+l91JGi1v?=
 =?us-ascii?Q?Oh3gBiiyGGTgWcVV3jRVdvknFexVg/CUrjiM0PK2OT4oVh9geAzWxzxSgr1Z?=
 =?us-ascii?Q?EOnrMxBJVl3k5Z+q6Grp9pYJelbS1holnhi+Dx+zPVKW223hKWHNw2mPU3eJ?=
 =?us-ascii?Q?dbTAD85eRy99DU3BvXysskf8BhoZFxShJXEXE3ExoFBdCa0PoB8jcLe/D7Lo?=
 =?us-ascii?Q?bgjfe9P3RYBSQNL2mxKCobHCjGTBYShiaQvqvkPJEaLqreCm4LKglgS3wTzo?=
 =?us-ascii?Q?33TuTu896gylDGFkoueVFSop+lP5m7EBHSADqYbv00s/CQkwA8hxP/jmLWP8?=
 =?us-ascii?Q?mBHzAKPRaTMyJ8bW99cpMsWqB/OnRsauschgG84bZtCJmtsKsNDRmdakhbgh?=
 =?us-ascii?Q?3pjD0Ln4Z1WCJii0WPmWMLUJCoqPgzLxn1hQ3tErNRfMUfUod6UylVg44KQQ?=
 =?us-ascii?Q?9chB4Sjk0rvRPC2lI2hUwgH/k8fClgSEsATuLeaizkAui4JeSDZpBFhp9KVF?=
 =?us-ascii?Q?m6NmIsvfUOpyEZzihC770dNCLmsvlvrKVhZ/jVKp5KjUoRlxQ4yPc4O+dKkF?=
 =?us-ascii?Q?iQTUh6rEVHG/sAHT0aflRZEf0kSAFUy28sfv+dw0l2RdvpJUqZcCbtOwlAb6?=
 =?us-ascii?Q?mtD1lzFfHnq8uvESwWFhfOs1glrbkhU3uWsHpC+RC4d1ISIOWlgT5i6XuszU?=
 =?us-ascii?Q?yzmPDkKpWPGgdYKnfqfZkASrRCuQwiNvupeTOkbeh4WaExfS6nBUpBgVurW9?=
 =?us-ascii?Q?5vGbqc/zAO5Tcddegi69uERsgroPJUXudR+OJ67vEXDoXK3sm/dQtAf9kb+H?=
 =?us-ascii?Q?tN5YQ/fafGOJbAb7nLDS+4bP9CbLvel6fV/KYIIaRtowVOsbB0BNKrhDdZ/C?=
 =?us-ascii?Q?1Zix5N5pTAHzELNHaVJWjskVpxcXXQ5/yXBSGVrFB4Y1JdvSBYUZr05+I3LN?=
 =?us-ascii?Q?znlF8kHQqLbslEjoPmN/rWwadhU0gQAwTJPSF6GAPQ34EB/8WDHW+MMGRz+I?=
 =?us-ascii?Q?q667iU5imZ8ZLQnmcJqjTBqfGbN77JnZnOW3MPcFP+dB9o9CA34dC5YPIsIW?=
 =?us-ascii?Q?0a4MS3fl6gjTJVAKVFoI4cFlok32LkvYR4GiraSMVkOosoUe7mLZXJfAPeP8?=
 =?us-ascii?Q?4SmKOwx7FFHjB2/lJuAIoUXJ9Ju64QOtIoECngwQrqMdFHEHgu3JwjqEqYs+?=
 =?us-ascii?Q?5sIIZonlYGuy0s9X099sypkM1WCVyj4v8ripVByGGRVWL3nmUHqpbWWQPwP6?=
 =?us-ascii?Q?LWRIDFvMvliMlhJOQknDsc3ZC80jE8lCticaVCVbb+GvRxoB7fzTWVWPR/iR?=
 =?us-ascii?Q?IIueO0wleyKm5asNxFPFzcHVqRvepXX+30LHreqGDlSoQO3tCA6LaGN3otCG?=
 =?us-ascii?Q?7jhYa1mi7psYmSIkwV2KltJwRtf5wyBCcd4s/B68zSbyaSmDKj1Q2/FNPyqv?=
 =?us-ascii?Q?sokyoSa41Q5UYyVXJjavQ5j6kXdBg1uzXecIQXvYS4guPJiw0LC0GugDGRcv?=
 =?us-ascii?Q?Fz3+ZR/3+OTdgcAdXvdmYLH33MuKbP8VB2NbTTflnj2E00iGxhPSQocilaY7?=
 =?us-ascii?Q?pCykdmylZU38ITnE76PBJOOaBcr4hDCXm+78zFLV87hQE1pwUZ6ODQ1Oq9Mn?=
 =?us-ascii?Q?Zp1wajUai2srdNTOUUEBJKBjEBFa2rK6yi5DuWmZ7YRZ1f5SlmP8UhmKBi2j?=
 =?us-ascii?Q?KWKa4l3KT1ySy3PGKxfqOD9IW17iM0D5qd21qmW+p0ukhIZgoqalWTGt/dSy?=
 =?us-ascii?Q?ICzdUXGLRQ=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f9e54a1a-e93b-40e3-7766-08da12812288
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4192.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Mar 2022 19:11:46.7358
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: u5iV6XWfUvyvMVWFdNZtyRMJJ7Csw8zRDdQHTkCFO2SQnc3d+11kXy1gPELHew+u
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR12MB1405
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Mar 30, 2022 at 02:10:17PM -0500, Bjorn Helgaas wrote:
> On Wed, Mar 30, 2022 at 12:37:20PM -0300, Jason Gunthorpe wrote:
> > On Wed, Mar 30, 2022 at 05:08:23PM +0300, Shlomo Pongratz wrote:
> > > @@ -350,7 +353,10 @@ static struct pci_dev *pci_host_bridge_dev(struct pci_host_bridge *host)
> > >  
> > >  	if (!root)
> > >  		return NULL;
> > > -	if (root->devfn != PCI_DEVFN(0, 0))
> > > +
> > > +	/* Is it a host bridge or a root port? */
> > 
> > This is a better comment:
> > 
> > /* host bridges must have a 0 devfn, but some of the entries in the
> >   whilelist are root ports that can have any devfn */
> 
> Is this something in the spec or is it just common practice?  The PCIe
> spec says very little about "host bridges" and I don't remember
> anything about them having to be devfn 0 or even that they have to be
> materialized as PCI devices.

I think we are relying on common practice here, but I don't know why
this check was added in the first place? Logan?

Jason
