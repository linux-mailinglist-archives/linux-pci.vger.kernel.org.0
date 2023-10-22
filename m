Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 462897D21EC
	for <lists+linux-pci@lfdr.de>; Sun, 22 Oct 2023 10:23:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229588AbjJVIXV (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 22 Oct 2023 04:23:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229500AbjJVIXU (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sun, 22 Oct 2023 04:23:20 -0400
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2087.outbound.protection.outlook.com [40.107.237.87])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FF33BF;
        Sun, 22 Oct 2023 01:23:18 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QAFjXp1ulliXfEkcHRRqb5GHTsukhQQ/BKhDz7UaLs7ejJa6Oi+3nC3NU8tvkSwqSfRxs4tBQr7b0l04d794PaFeujbK+UYXgSuTb4kk2ujUNhZP4lsUXmpD/RCoK4VdpY2SEXadeMHhqbzAuLudRcTQIjiixmBGpHt7Vf00MTdvDEtw5+LV0Itao/aD8XLSmR655nE8eT23XNPOw1SeNMRPJ6/9SK5VSeh69tPV+h5AYm9vcDg89L5gZq88v3PzEuAwNvGpYk+uYsuR4mZSZGb/Z7Nmjl4D1H5zLAcHjlflxDA7lvWuhU6HXxYaih9ENXxGW3d7MQ5LfosJclt0wQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7pWvyPJVsdN76GpHoeM83MmFjZjUZbRfUj7xrGKq18Q=;
 b=X78KtLAHXPlgf5a+2ReJA271dlrzDRLex5+Ks329ykEiBMV5CYBbAZiummuxhEN7a6Qxo7udBeXWFYlQlUxOM/GtqySURvkAVV/051RWGiS/nGxtPdUphQZ7wOPuflAtICDrITGnv19+7QPq9kTLcwsaXQQZGWE/PSy6OXDbeSbWmQb4OMSCnpDNA7AqNSOJrTpvQhP2fd8uTU2uo8PC2ddT9+eCdQrK6asTkVvJUiXIfXDPMBidgeXkfxu/ZTcu4OV2BpMZEaEvt3uIQID5B6SVqY2+fupOFjrdvlcXQ06w+nqSQUhFvX49Qo9XCLJUMidD8awBCTKz+qNFEvPWSw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7pWvyPJVsdN76GpHoeM83MmFjZjUZbRfUj7xrGKq18Q=;
 b=AA+z8pZ/tAfVgkj0XuMiWBfVvDEfvGB/zIeiqaQ48DP1p0lDBrY66zduqRRSy30L+b5aQJxe+PcUnHBzXCAUKrAhWG/b+eN57aFFpP9a30j1javLc+uV3128SjT3PAx61NOusLYbwY0mlphi3e+GtFMp6qU6kF915WnQ7ITd8865u4woHgaemljt31zOnQsWvGDatSj0A1zUPMo6psnqmIll9m+AlNzJWmJlCHB1D6X/K5plonVzcqLEthL/MRkApmZqEA0oX2hJNjru52+4J6Z4o6FWzX6lu8bMwuWK5Q866oMrhiwKnD5p0ZMm/EcbqxinunYnuR7tB/zcXxRVwg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CY5PR12MB6179.namprd12.prod.outlook.com (2603:10b6:930:24::22)
 by CH0PR12MB8508.namprd12.prod.outlook.com (2603:10b6:610:18c::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.26; Sun, 22 Oct
 2023 08:23:15 +0000
Received: from CY5PR12MB6179.namprd12.prod.outlook.com
 ([fe80::6f24:e252:5c2f:d3c9]) by CY5PR12MB6179.namprd12.prod.outlook.com
 ([fe80::6f24:e252:5c2f:d3c9%7]) with mapi id 15.20.6907.030; Sun, 22 Oct 2023
 08:23:15 +0000
Date:   Sun, 22 Oct 2023 11:23:08 +0300
From:   Ido Schimmel <idosch@nvidia.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     netdev@vger.kernel.org, linux-pci@vger.kernel.org,
        davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
        edumazet@google.com, bhelgaas@google.com,
        alex.williamson@redhat.com, lukas@wunner.de, petrm@nvidia.com,
        jiri@nvidia.com, mlxsw@nvidia.com
Subject: Re: [RFC PATCH net-next 04/12] PCI: Add no PM reset quirk for NVIDIA
 Spectrum devices
Message-ID: <ZTTb7KSgdQcvxdDq@shredder>
References: <20231017074257.3389177-5-idosch@nvidia.com>
 <20231018194041.GA1370549@bhelgaas>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231018194041.GA1370549@bhelgaas>
X-ClientProxiedBy: TL2P290CA0012.ISRP290.PROD.OUTLOOK.COM
 (2603:1096:950:2::16) To CY5PR12MB6179.namprd12.prod.outlook.com
 (2603:10b6:930:24::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY5PR12MB6179:EE_|CH0PR12MB8508:EE_
X-MS-Office365-Filtering-Correlation-Id: 5ddb5ed5-9817-4db3-be30-08dbd2d8231b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: q3FP3eNdRwaNs2aluv3c62e9iY25nY9FOrR4dO9BVq0ZAkIzqpRrRCgKqPmkN2apQFA/Gh0CewGIgsyMo9NOiQZ4k1B0Q34A1Gnn9b0XjNEXxO5IgfBBfb7oygqgZTAWJtsz30pSXPOVk14+JeZre9JbotqKDJ+1XeAWdWlY1wjs8O0aPx/8jap70lXqqGbrJvAxkhowUZ4cWzmrRxD3JT1ZW0IR5nncYnpIlnsgZOvUXEbaFs5BpcLdEC6TyEHWyPbemdK0sNFJ1Bs4wyYis74WaMyeQjQqNeHGFZ02g1h4W35NOcWlSGyo4NzCKvkNRrEajef6d8Snh8JuX+BqFmuCUCTJDjYIMCcJQx2sKhKiVuWuRRObSr+yHG0Sz6JVjm2OT4hTPUd2TlVJThrluNZKwlD+TUmIhXOUIQ1n5eGsKUjnmB4FcFvew2rEEvsIituVQhlPXUoWg5WnUjVC90hmY37cUKB4xI9jhO83Z2hZjRtdKc1Yc1tsqS90oMH5CvUa7XcIBK2mCWG4DunPfLND1RagQUHx9abws9W94FdFJzHr1F48QN3qD+S9qk+a
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY5PR12MB6179.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(39860400002)(396003)(346002)(366004)(136003)(376002)(230922051799003)(451199024)(64100799003)(186009)(1800799009)(478600001)(316002)(6486002)(7416002)(66946007)(66556008)(6916009)(66476007)(4326008)(8676002)(8936002)(86362001)(5660300002)(6506007)(38100700002)(33716001)(9686003)(6512007)(2906002)(107886003)(26005)(41300700001)(6666004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?DGAk+aNgVaYQ3ZcRd7iQpMAbkHvIupqSQKf+lQTx6rjhjQzVk/pllbbSXqes?=
 =?us-ascii?Q?b/reBk2A/y3oN+Xu3y6c9L3f77YehRffFyhqLhA2UVYo0Mt6MWkAoG4JgTSA?=
 =?us-ascii?Q?HRUB2e84lBtOBcZf807OWCk8V//TBlZGihsTprGq7Jt+RgA+jZRWaYA5XvT6?=
 =?us-ascii?Q?ogKm12O9+2oAn8hablI7UXyITUoJTwCdWvagrTdwauUgDhjkLLkFUHhL4Xu4?=
 =?us-ascii?Q?uVPnmLtc885cWWlpTrKsvpkB7BYeXM6c+WOz3mu3zwwiMFvKPNcfJqzGmSJa?=
 =?us-ascii?Q?Nv000mjGuLzw17QYbAlWrWn8TP1PGWuXt1qKMQ/WXXvBCxlVcLDfruBUkd1b?=
 =?us-ascii?Q?FptMQzuBmh4NIr7Chv6TstcFJLo4nLXxxvrFN/+/8iotthb9U63m0Rx5VC1B?=
 =?us-ascii?Q?VshHmLSfyyki5O8s+9hJeQMHDtJQi/ujy0DHMqtkgmotvaAaeOfyVqjS8kto?=
 =?us-ascii?Q?FnZSBtOv4DB6JcNn+dmFn2h63viJFW5ARWchECJkZPF8vrFTQG/c0e1FzPWV?=
 =?us-ascii?Q?jm8XaTTgLPF5x3z7pTqOjBh8osZDkbzjKM7gP6TyrYmCHrAfJHMLoDZ24DnD?=
 =?us-ascii?Q?wvwvdo+LwKojK8UIWJDKJjZyhYc5oyxOCavqL6bFQfrQet3ZfqQveorkBBhQ?=
 =?us-ascii?Q?RdW2ZFfeHdcl1FXR764XgA7ucqxcDxCI/Un1S0XRWk3DRxGz/3mgJboIaV9o?=
 =?us-ascii?Q?rVM2dCbQnO3oJ4B3/guUxwW58l9W/nPPMn3VX/0tatA+FMPG+ne9dRfx1k2C?=
 =?us-ascii?Q?6l2ZU75Gn4z4IsP68ATXUKcUDlw0m92owctCYQzhPT16LDN5vKs3+psgOCF0?=
 =?us-ascii?Q?f3keFjJnhWOsqCIOybQgTyUlBrhVfecZN+5kyr5D5u6UKFReHeZlgCBpK9FB?=
 =?us-ascii?Q?qInd4a+SqqMBy8FTjlnGCuAlYkjHAzN+NrwXarJxaWxvQVCY4NFfqbz0AQdk?=
 =?us-ascii?Q?v2qlIUlIIMuEycoN0gS8ybEpNPcBZmbHx+/8gdVdQmy/CYiw0Kj3FKDZgiYD?=
 =?us-ascii?Q?OhzcENhFopYLgeu6LnpxW7OJXyn5CRwuzns6j/iszQyInoeGq5MY6LnQM0us?=
 =?us-ascii?Q?VcPAF4H+WepqrzeQVk/C5hEl8/+OGc5EcwC2ewol1UyN0V8dG8vxIT5dTHP8?=
 =?us-ascii?Q?G+wEsWF+SKduguYofnZjPIRWL4soSSKpnOXd+NroFUyOCdNMh1gIuJe8w8lT?=
 =?us-ascii?Q?PxXABxt0UcPLZSJz6PpIsLt0u3tgR3ymSwu1+GOAq5QxEcdgQOjIGlHcx7YE?=
 =?us-ascii?Q?XTPhl+5ZrthRSp8e7GXgPbrNTtj/Bam7m8lqSZdhRjr3XKaIJXFIQ+ISI/p+?=
 =?us-ascii?Q?ceUAG7SJg51+otbPpYy1d5dP9pew/plO2CVZr+vMzhkm4J8uhPPnN2yqvDpm?=
 =?us-ascii?Q?t/EbpfH/GvWyLHC1HavjTDcylbfdE23eEyjrdxo+KM+ui+pZgQfnbJTY/yPo?=
 =?us-ascii?Q?ZyieORD0VAzeWbOg4DrNNrEsAjVprS/XpCFoyj8SQcFdNilFSbL9aS3rrYOV?=
 =?us-ascii?Q?HOaALXWUyNnYRQ4dkF0DLmQR65NZdPJd1KA3BQiJap2adDH6VPlll6yvBUV7?=
 =?us-ascii?Q?VemIEfNRfKzg7wyvEllTjSpYT2PZuzhlJdk7iCqy?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5ddb5ed5-9817-4db3-be30-08dbd2d8231b
X-MS-Exchange-CrossTenant-AuthSource: CY5PR12MB6179.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Oct 2023 08:23:14.9716
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jrtCS/mLVWv/7vj13q1ONrQ9OrNmA+RI+B+IkU6oVEmKDu2ZOc3+Qe9PqxBvHC5ZuN26zh+2oOZO1MchnMkmQQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB8508
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Oct 18, 2023 at 02:40:41PM -0500, Bjorn Helgaas wrote:
> On Tue, Oct 17, 2023 at 10:42:49AM +0300, Ido Schimmel wrote:
> > Spectrum-{1,2,3,4} devices report that a D3hot->D0 transition causes a
> > reset (i.e., they advertise NoSoftRst-). However, this transition seems
> > to have no effect on the device: It continues to be operational and
> > network ports remain up. Advertising this support makes it seem as if a
> > PM reset is viable for these devices. Mark it as unavailable to skip it
> > when testing reset methods.
> > 
> > Before:
> > 
> >  # cat /sys/bus/pci/devices/0000\:03\:00.0/reset_method
> >  pm bus
> > 
> > After:
> > 
> >  # cat /sys/bus/pci/devices/0000\:03\:00.0/reset_method
> >  bus
> > 
> > Signed-off-by: Ido Schimmel <idosch@nvidia.com>
> 
> Acked-by: Bjorn Helgaas <bhelgaas@google.com>
> 
> Hopefully since these are NVIDIA parts and you work at NVIDIA, this is
> stronger than "this transition *seems* to have no effect" :)

Yes. Reworded to "this transition does not have any effect on the
device" and kept your tag.

FYI, new devices will not advertise support for PM reset so I don't
expect this list to grow.
