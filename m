Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D3A36302CE
	for <lists+linux-pci@lfdr.de>; Sat, 19 Nov 2022 00:17:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235382AbiKRXRa (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 18 Nov 2022 18:17:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235488AbiKRXRF (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 18 Nov 2022 18:17:05 -0500
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DAF86DFC1;
        Fri, 18 Nov 2022 14:59:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1668812390; x=1700348390;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=zql22inLk+6cdJoABnN83BOBzNfuQv7Fg32ei7eN3cs=;
  b=TcgX0N7dlDvrJoAzvLm9wgeSpbiGMPm61GCb+CyzMwt2/RcBJ4eV3Oby
   /glNpUYyY0TINRf9KfK/oamlSnayTf10yuBrY0nbUqqCNadHHNVwBqmzm
   TFMpBoQ1siJVk2a453Cg8B6t3KEjpPDvUL18y1BzdS08nBh4fjqqVvmFu
   JRQ0rxDFW7O7rnKJLSZgHeeeIdXrTIWW/l6dyvW3npJrWB62cLF1Eg5Vf
   VpXFF6EpCKpwQ4fSnvTiIODP03vo5eNrpq6olrOefFlgacWXMNtqJPMod
   jtuJ2DrZJlzHBPZ5iBPgFUei5d5uDIz5dSy20hdFNWA1N2qFu4AqDkZO+
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10535"; a="300794211"
X-IronPort-AV: E=Sophos;i="5.96,175,1665471600"; 
   d="scan'208";a="300794211"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Nov 2022 14:59:47 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10535"; a="618178253"
X-IronPort-AV: E=Sophos;i="5.96,175,1665471600"; 
   d="scan'208";a="618178253"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orsmga006.jf.intel.com with ESMTP; 18 Nov 2022 14:59:47 -0800
Received: from orsmsx603.amr.corp.intel.com (10.22.229.16) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Fri, 18 Nov 2022 14:59:46 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31 via Frontend Transport; Fri, 18 Nov 2022 14:59:46 -0800
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.176)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.31; Fri, 18 Nov 2022 14:59:46 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=A4yrOTY0sTehCEutbtDE0Aw2MwkqzjFGQvy8OHsI7R3Abht4uuj7h+RnfZL5eX5WHFwx2j5zPZvVY0qHLKgqHWarnmczrYxVxvp5CfwMLuzs0sKFHvImkrXMRM6D6zDPWBLt+rUgPADD3XSC6FZB1XBuShSQFCauayKhcuEgkCt0/cTCcygwIIhfY/B1cNIzlHOhgY1K82xg+1PN3wFNAHrBVOYgDerpq3OJ0KOjfZIHmaEgDtqCU1F6CI0xY6S8V4pNXQG4DNAbXtjIP8GiDC6kDCUaraAcpa5k9kIEltNtgJnOWYUHkCadzFuT9gP+7o2TNoEsOcdWks9Jy/tBSA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zTgS1O4qKkBM6eLfDeRDTVj6CALRO9QpSpH8I4ugdpQ=;
 b=Z51F3lgjlCewuWfaIEAOQdE4Vf3jWXSe7q9fY979hhxLBOqeKPgHwYS1/ckSAfcfVC8wRUN+yEWFLftbG2GaHHwZEzVzMHnNXETY7ox5KztlRb9j38CC+2hkPS/VBT2L2cYUZu5Dcaev2hfKGYiOirOLf6TWkubjGvgUpVDgwTyIke5x1L2xJlWaUdamCKQ4PDe5LDb/cj7O5qGRuDuqkywao8pp+eclLKwWfD6O9USi63rMTjgsII41TV++9aj0Gv47XXTs5MVip6Rc4Q0wLbjT5lD13xHKCRCnOqvk7HPUyWWXO5H/Icv7iTaakVlPQkzb+/DwSJ1FPcpbsLAKkA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CY4PR11MB1862.namprd11.prod.outlook.com (2603:10b6:903:124::18)
 by MN0PR11MB6230.namprd11.prod.outlook.com (2603:10b6:208:3c5::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5813.17; Fri, 18 Nov
 2022 22:59:45 +0000
Received: from CY4PR11MB1862.namprd11.prod.outlook.com
 ([fe80::207e:ab0b:9e29:6a4b]) by CY4PR11MB1862.namprd11.prod.outlook.com
 ([fe80::207e:ab0b:9e29:6a4b%12]) with mapi id 15.20.5813.020; Fri, 18 Nov
 2022 22:59:44 +0000
Message-ID: <36615cba-4429-a493-a533-d7dc0bc46056@intel.com>
Date:   Fri, 18 Nov 2022 14:59:39 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.4.2
Subject: Re: [patch 21/33] genirq/msi: Provide msi_domain_alloc_irq_at()
Content-Language: en-US
To:     Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>
CC:     <x86@kernel.org>, Joerg Roedel <joro@8bytes.org>,
        Will Deacon <will@kernel.org>, <linux-pci@vger.kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        "Marc Zyngier" <maz@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jason Gunthorpe <jgg@mellanox.com>,
        Dave Jiang <dave.jiang@intel.com>,
        "Alex Williamson" <alex.williamson@redhat.com>,
        Kevin Tian <kevin.tian@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Logan Gunthorpe <logang@deltatee.com>,
        Ashok Raj <ashok.raj@intel.com>, Jon Mason <jdmason@kudzu.us>,
        Allen Hubbe <allenbh@gmail.com>,
        "Ahmed S. Darwish" <darwi@linutronix.de>
References: <20221111133158.196269823@linutronix.de>
 <20221111135206.463650635@linutronix.de>
 <0cbf645b-b23a-6c85-4389-bb039a677a52@intel.com> <87k03tkrii.ffs@tglx>
 <87zgcok4i2.ffs@tglx> <87wn7sjzeq.ffs@tglx>
 <d33e63f0-a5ba-38d3-1cfb-dd5ab8d249b8@intel.com> <87y1s7j3o4.ffs@tglx>
From:   Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <87y1s7j3o4.ffs@tglx>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR03CA0109.namprd03.prod.outlook.com
 (2603:10b6:a03:333::24) To CY4PR11MB1862.namprd11.prod.outlook.com
 (2603:10b6:903:124::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PR11MB1862:EE_|MN0PR11MB6230:EE_
X-MS-Office365-Filtering-Correlation-Id: b9c170e2-c0ce-482c-765c-08dac9b8946a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: YuqAN6iM/7/TuHIyyBkHZTfCn6VktOD5UGOPabyErqk7GwhYcU9o+MZTjNABeqtri9Rz5EZxyGZHYT0DfsmlmJsxCuer3BNd3PTHaYAmmi7T95ins0de3eTFRLrNxl0VUHhlbaXxuF3JEoJsy0yT9xyz+1o2s743YNdVUmh8oRcjQusuNr0FXl9Knp1A7y7b79rG5UcvcoLUgpAqYtm/uVlyS++cOeG49U8USOhEUbxvgUTB2Epq8J/Ds4zif367vwSXty9MD9dG4+SfcmUchcM5E0Xk2tExc7LUYIC0r23zXiiJvqqQvqaoi3v4cRvfXXokoiecgTuoAbLMZUQw1MWUXt3orhWqWfpu/zte8CvcenSsUzDKBcKe9DqgxAC4s5uqQbAT4hcAaInwUYuvd2f1ctWTkkxqeC2dQ3raLZpa1Ytcu0ugmELiHeXGeoW09UimtzsOeMijDa5XQGOmq3A36+Kvkc6HgId1oVbT9X+WrgQu5xqwZTpI2oYQq37hWaDTcWk7mydbc00zXvFFfyV/Cw6ZWkQgQevbUJmkPvlEQ4x61GqEp2h8e5Rj8nt9OJjJhuBC1mpIyOLAQZi9+diKPntev9k4UYfTNk7aobpYkHl0ziwZW4podbnNWT4s+tR5N7Zp2PVSSh1fo9WY8m5GaJC5M+0+ig8UeoqIT7/VzUGX/XmAxcKFnUboUp6SIudKxk/EDmwtVPODwJh+XfNWVKUHCRIVNyJFKfnIRzM=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY4PR11MB1862.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(346002)(136003)(39860400002)(366004)(396003)(376002)(451199015)(2906002)(4744005)(83380400001)(7416002)(44832011)(5660300002)(8936002)(31696002)(2616005)(86362001)(186003)(36756003)(82960400001)(38100700002)(41300700001)(53546011)(316002)(31686004)(6506007)(54906003)(110136005)(66476007)(6666004)(4326008)(6486002)(66946007)(66556008)(26005)(8676002)(6512007)(478600001)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Wlg4Tk9pUHdPRjZ4TGxLWnV0NlNwckhYV0RDOE15WE40ZDVMS0tVdHpYVFZL?=
 =?utf-8?B?YjJ0U0N5YmFhL3FyREgzQkZVSzhRQjljSzBmQk1VdytHbkp5L0l2NldZL3ps?=
 =?utf-8?B?cUozbGNnOHh2MFNXSHNGdFgyTHZRWTRQVThuZGEwVmxsNlg2aHp5TGhERUpr?=
 =?utf-8?B?UEJreUxqMlZkb2pyQ0pwQk1EZGhOSVJISTd1cm9vTmxodzg0Rkp4NEQ5ZE9o?=
 =?utf-8?B?SDhQSnQxTk9UczNOY1dnM0pVZmRveVNoOGZHc2NxM3AzbENUOTdVdVUrdHZU?=
 =?utf-8?B?akNkZUdVWDBMSjc2d01meTcrbUF2VDlhbDVmc1dyZGJqeDZPUU1OMmtocDE1?=
 =?utf-8?B?aG1PTWNwRWFTQ3YyN1RMOWZVSDV2TmZ5RTl1Z09RQjZiZFJILzN0RS9zbmlF?=
 =?utf-8?B?V0xWdXdqdVg3UmJkdFFJMGVjZlhUSHg3YXV1M0o0NVgrOUVQNjZHeWl4V3Vr?=
 =?utf-8?B?d3EyOGJWUENSdzNUMDk1Rm4rcm9LZ3JyVFBYOEdZUGJ6dFg5MWRybTN0Nzg3?=
 =?utf-8?B?dk5EQ2VMRjZBSkE0UGpWcUVmVVZuam85SXZBU1liOThQZ0FPL0I3aGN5bnNH?=
 =?utf-8?B?NmF2bmMzbDhCQThIUVlsaE9Ob1ZBNGEzd1B1UEhxZnlpVXcyaHRHRk1iWVNG?=
 =?utf-8?B?WmNKOU1reXd5eDRwQzJKdHJYQmtHb1hmVVExSmtGb3UyNGFWV0pma0R0Q24z?=
 =?utf-8?B?UVJhVTZ6YTFuV0ZmU25jakxCYlRJRld4aHRpNGVrSElScTJIZEpHUUNDUVpT?=
 =?utf-8?B?bDFlTWcwNm53TGVzSFowc3MzNzN6NXdrdk00UU9HSlhaakEzSG52NlZXOG9B?=
 =?utf-8?B?MzJVTnY4UDhmT29LSGRUekM1OVlkTHo2R2lhbzJ1Q3VnMFp3d1JnU3JrbWpG?=
 =?utf-8?B?SHRoSzlyRURvbGM3amw4d2Rtd2p2NmtRUUFwMG42MmpvRzNuUkFOWVFQN2Rv?=
 =?utf-8?B?VWhsUUNDaHVEV2UrSnhjNUowbmtaMk5VYnd6cDM4UUhtbVp3ZWI0d2I4RGFo?=
 =?utf-8?B?SVJtSmRZMVFuL1ljeG4xWDBHVG5FNmpWdUNBZW9wWWpaWlIrWE5vYVlKSmd3?=
 =?utf-8?B?c0piTUZKMlQra0xmT1M4eVRtVy9rKyswWHRYQ004YXJvT1hxemdSazJVMkE1?=
 =?utf-8?B?VWU5enZOR2dlRStJNkYrdE92blJ3Nm1qTDVkUVovZEdpYktNaFl2bVFiRi9O?=
 =?utf-8?B?cXhhOXZzeDNZY1BSdm1mL3U5Z2NRcGduZmZNZVMvSjh6K1VIazgyZEExcXVG?=
 =?utf-8?B?Z3k4ZFVzcVVXNUNNZkpGYWZTZ0h6NDllUmpGcnRvRnFzQ0t3SFByMmtMcjNY?=
 =?utf-8?B?NlFCeFBST0dQWlJsU200TlhPU2R6NHpQM2NOV2NZQVpJT3hHdDNSU250NDFs?=
 =?utf-8?B?eHljaDdFOUtLVXVRbk01TndDTGtJSUp2U1lSUi9oNTRIMXFDMEZFU2NRWmJO?=
 =?utf-8?B?YXZzdHNtbkNVVHJPMFZaT01md0xhTnRXWHlEc0tFczN2eWR4NjJFOG93QW45?=
 =?utf-8?B?NkgwQnRFV1lXOXFKWjhDbmRFbkhYdXlKUjFVMmlRdkhYSlBWbDd1KzljV1c0?=
 =?utf-8?B?eXluUldiN1RsalB4VlBwZkRUR21TODh6ZERGaEFJYXY5WlpiOVBqVlhPWUQy?=
 =?utf-8?B?aWJtYUVaS0o0OUFtTENQNmVBNDFsUmQvY1dtL2xBbStmMGhQdFlWQU50U2JD?=
 =?utf-8?B?Y1gxcjJvanFkWXJyaytvNHdRbXYvYkRGZU1FWWQ4M3NhZVh5dnV0eWV5anM0?=
 =?utf-8?B?b1VRR0FPU1NFUGk4MGl0RDBHS0doakZyUW12V3FrTWFLdS8rRm9BbnNlQ0lk?=
 =?utf-8?B?VXRGaUdkak5KQ2hKR3VDT2I1WmNGZjd6aEFaQ09MaDQ2S201YW9oTXRWYjVt?=
 =?utf-8?B?dS9NNUlSdVBDSTIrSmlxTFlmZjBVbnJWTEJ6TlQ4SE9MY3F2OWlpV0hUVGoy?=
 =?utf-8?B?MVlTOFdLSmttUy9tZURNblQ3UWljVHRsNmZDY0tOckpQblBLQ3pqZWJsam1W?=
 =?utf-8?B?bWROUjBWTHQxL1VncGUrN0c3L1V3ZUpEeG4yQWs2bEgvOFZJNXBoM0k3WnR0?=
 =?utf-8?B?cW1zb1NCdnYvSjYvcjBXT3d4cWFPTHAvK1d1cHhjRkgvNUI0R1UyQ0RXOVNw?=
 =?utf-8?B?bDA3M1ZDa2VPN1ZTdzhTTndvb0hWaWNWMS9ONk1KaC9DTmU3YVVHbjZ5MHJX?=
 =?utf-8?B?TUE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: b9c170e2-c0ce-482c-765c-08dac9b8946a
X-MS-Exchange-CrossTenant-AuthSource: CY4PR11MB1862.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Nov 2022 22:59:44.0797
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UNCY7xK3JloRf4J81PJjsgKvd/sqT0nHc+QTT76RkzL1jSryN/6qPDVobGMjNV7KE8EplWm/0hg6mjs2oKBjsWJZwyaoaHV9hFgF/dMMy6o=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR11MB6230
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Thomas,

On 11/18/2022 2:31 PM, Thomas Gleixner wrote:
> On Fri, Nov 18 2022 at 10:18, Reinette Chatre wrote:
>>> @@ -141,7 +141,7 @@ static int msi_insert_desc(struct device *dev, struct msi_desc *desc,
>>>  		if (ret)
>>>  			goto fail;
>>>  
>>> -		desc->msi_index = index;
>>> +		desc->msi_index = index - baseidx;
>>
>> Could msi_desc->msi_index be made bigger? The hardware I am testing
>> on claims to support more IMS entries than what the u16 can
>> accommodate.
> 
> Sure that's trivial. How big does it claim it is?

2048

> I assume your sequence is:
> 
>   pci_ims_alloc();
>   request_irq();        <- This creates it
>   free_irq();           <- This removes it
>   pci_ims_free();
> 
> Right?

No. My mistake. Sorry for the noise.

Reinette
