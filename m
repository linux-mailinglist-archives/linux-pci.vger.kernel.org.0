Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D0BA86BD1AC
	for <lists+linux-pci@lfdr.de>; Thu, 16 Mar 2023 15:01:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230236AbjCPOBx (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 16 Mar 2023 10:01:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230332AbjCPOBp (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 16 Mar 2023 10:01:45 -0400
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-vi1eur04on2059.outbound.protection.outlook.com [40.107.8.59])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CE46C4E91;
        Thu, 16 Mar 2023 07:01:32 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IvyXkVebJZwwdhhXuVX+CAELvqgxaitJ9Vy83i+9cjB7FX+2XQpSt+uzw9DEKS2Mrqr1Y4f7vs5UEXzpFXemqdNhtJXc4qjYrYl7dTrwyMGmFGJwbm7Js04+tZFD0Sb6V0TCHlRqplofWAUId72fTDuIGXKlYl3Dg8PaIDwj17xw9xnYFrIb59RSkOkgFTKQZxqxsmbkkbdmvrgLO8Mw47RK2t4cPsId/24KhRa9EYGdmDbrWDloPyvDuAsvex1fQ4hGpg4Ls9wXW2ShDNdpv71rHzgp/lEHqCDlK8MYFVTu/ZuxpLADg6nxDkCJjaDfnfHRtsG8DINFlpa8ujMmdQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RQ/pnB5rUcVVLqx0UkbB3Os4/qxVjNWUGB2pz36D7So=;
 b=j2wz0O5aYmPwEvljKM2pDiObUKdgJp3aEh+f2iPPLZJfTYYX73bMizsE6eRLGzkUJ+ZzPz2ysaXNpe9D0dF6DvLUE5bpMnL1mkE3pRZrpn7dTORaM5WgSjxdNKi+oxRi/7DrYcdVpOTYjYwsMZH42gYBOxg/ftyme5nSXKWCQzyD0SBh3k40KU3h9rF80rV7JwzfLMUp4vAMGOAHEuOg2zAGsdklWmO/6wju9vrSNJRcdBL5pS3Xe2+0F3aLQCqjDLHPAL+ZTNKoAcKbbh7XkWHJNdf/bT35Hbvp+etSe74ZSweBG+RdDubt9NukQfVFNdYpjhm4/mF2CuS5c90Esg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RQ/pnB5rUcVVLqx0UkbB3Os4/qxVjNWUGB2pz36D7So=;
 b=ZC8h+IK/aJiDTNbgiITKukyX9FFWPPjrrIt7H2mY0koqWZIiUHOjVT836MfSfGIPIED2VxeXG0x5yj9GyMeRP2fUd6YKSn03j1rp+YY8INZO97sYgX4TH0OIe5PJ2pm3+MxSK7uBoS6QydxQ8BskbP03wVN7yeT5XCbuF5qHJlv3sRqn1Ly9R+CzsHY6KA8CjNLJUinSnS/I2AGA3td88FPdv+1bu2Oqqb0l3cycPlcuUtXUW4F+BR9V/tRNyoduyejq5UUwUDHvPnVa3r7zoiADMPoELYx62lM5mrwy3PoeI93ebTguiLrz21iHLg4pb5TgLTQl24IPmxWlRqz5wA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from VI1PR04MB7104.eurprd04.prod.outlook.com (2603:10a6:800:126::9)
 by VE1PR04MB7213.eurprd04.prod.outlook.com (2603:10a6:800:1b3::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.24; Thu, 16 Mar
 2023 14:01:27 +0000
Received: from VI1PR04MB7104.eurprd04.prod.outlook.com ([fe80::2ea:4a86:9ab7])
 by VI1PR04MB7104.eurprd04.prod.outlook.com ([fe80::2ea:4a86:9ab7%3]) with
 mapi id 15.20.6178.031; Thu, 16 Mar 2023 14:01:27 +0000
Message-ID: <ced8713f-69de-e48a-37eb-4f844e651b6b@suse.com>
Date:   Thu, 16 Mar 2023 15:01:25 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH v2 1/1] Guard pci_create_sysfs_dev_files with atomic value
Content-Language: en-US
To:     Alexander Stein <alexander.stein@ew.tq-group.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Oliver Neukum <oneukum@suse.com>
Cc:     Korneliusz Osmenda <korneliuszo@gmail.com>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230316091540.494366-1-alexander.stein@ew.tq-group.com>
 <4888964.44csPzL39Z@steina-w> <90e97b96-2918-294a-0e71-33a42f28d8a8@suse.com>
 <3607385.usQuhbGJ8B@steina-w>
From:   Oliver Neukum <oneukum@suse.com>
In-Reply-To: <3607385.usQuhbGJ8B@steina-w>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR0P281CA0051.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:48::12) To VI1PR04MB7104.eurprd04.prod.outlook.com
 (2603:10a6:800:126::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI1PR04MB7104:EE_|VE1PR04MB7213:EE_
X-MS-Office365-Filtering-Correlation-Id: f0833c23-0d79-4039-1708-08db2626ef8d
X-LD-Processed: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba,ExtFwd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: pXw0nwe//mjVHn2OlSKl1LE5it3TThe7nUgnHtHSgpY3Kx9ZJQWlB0eBfR2dtDp/h0BmugboVBSCpFGDLq6GqUnIJAMKhDRoRDh9aBsbU3OVtXBNnSeZucIG94WmzGAZE/8wCV9LhdV55WhnQjBOD3XOkKZr2Z2ygHiLOEcDx6OqlQjqvwrabiyt8AoXK826ZskhGRPLsOlmzXLnhY1PEZ8RuVLJlbzcl4Stt1QfX8mQfgZW4BXdLv6emwjecQdQiRMT5e2kkHyPKDhbNlLk0uO7sVioZCObmpnCmRoJ55eSWJZyVxY8nO4goI3XPtoFp/RI9QoQqSMbromUVmQlP3Y0fppzrvdnxXl53PKkUfN6haQm+mhAq5ykcvOJxWwVxyLeQwaPhOjvGaQ2HHsFGG7kCzK5cDv5qOzXvfSuDW7go2T44pNXCSl5mShJa9iXYKuZx8cBApeK//84IaORMgB5kf+hIB8yY6Pr58Isw9qOfGnxtVlWqGnBQ075S3FDVHMOmILbNP4m/4SKHJP4JyUJ+BAQ8g8ZxL2KUMWvy/0FSWy+LddQhPWMvlR0AAou3Lm6SXQ/+++47c0tktxqV4i5HWxlmUE9tZ0aUv8s3c/A377D3Vqv4BFi1/zLNpTagoKzv010QWzjXhf7GmkxMs0fHzdQKlcxptaPvxCeI3BOiwChPd3kSD1NN3zbzCeuu932Xquy2J/jpz46iMVpz5NUO35GLw9dTej+jkjCNd0=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR04MB7104.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(396003)(376002)(366004)(346002)(39860400002)(136003)(451199018)(8676002)(31686004)(5660300002)(2906002)(36756003)(8936002)(41300700001)(86362001)(31696002)(66946007)(66476007)(66556008)(110136005)(38100700002)(316002)(4326008)(2616005)(478600001)(186003)(53546011)(6506007)(6512007)(6486002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MVk0MXhSVEkrZkI4TVJUMTFBWEJGT3hyYjlOaDVpUnRVcVE3T093bXoyNFYy?=
 =?utf-8?B?cGw5ZHN2UmxaZmJ1dGlLTnNzT2ZtODdKWTVLOWFEdHdvTDQ4ZEQ5eHo1amJl?=
 =?utf-8?B?WnlMVFZQTllkSjNhcGptL2JZVFBVUzQvM2E0SFpIVEc2ZnBpeG9EekxYbUs0?=
 =?utf-8?B?NGFPWWlEdmluaFZ6QUZXTHJibDBobk1STHZXNTdmNXhSY3g1V1VaZUUrRzNS?=
 =?utf-8?B?cWYrOXg2R1VyUDRjNEp5bmp6TmpvWmtLd0QrcUIyWG4wL2l0NzV4UjJZa295?=
 =?utf-8?B?cE5qemtNb2JBeDQ5OFpFcU8zOTNINjNQYlRrVnowazY5YnZSQ1dudU5nT3Bi?=
 =?utf-8?B?Tmo3TXJJNURnaWxLWDJOTjNGVmFISTZjc01ueFBzL3AwcTNKTVMzTXVha0hW?=
 =?utf-8?B?YlhsTVB4d1RFdnhBVFlSNHYvZ3ZNUWs3WFJYYkRYRSt1OWVrdm83MXBSWm00?=
 =?utf-8?B?c2ZtbXFKYkxzQnhlMGFTTVp6VmVrQmlialZoWUtzWGlxWjV5a3dxRTVwcWlL?=
 =?utf-8?B?U1E3T3JFYU90UmtwZE51ODZSRUdKbHVrMVN0SUs5LzVNTGdSWXVTYVV0RUI3?=
 =?utf-8?B?eUVHbSt3NVZsc2JHUHBYb2N3TEU2c2tyOUNXa1JwbWJMRnRDSnZuZVNudlRx?=
 =?utf-8?B?Y0NZczhTQkFZUk12NTVtZDNFRzg0a3Y4MVZldDE1cHBldW40NjV0a0lvWjhT?=
 =?utf-8?B?R1ZsUU9MSUJ5dnlucG9SVWNkdlZOcnJrY0Y0NGFxSDVkaDBvQk85ekQ3WTVI?=
 =?utf-8?B?R0hmM2RIeEdkMDZMZzBxbURmclZONmdYTm5GVzB5RFhyNzZkVkNiS0pPQ3Fy?=
 =?utf-8?B?ckR4RldpVkRJcUpaempISXFFWnRjY2JFQVFHbjFHS0lBYlFTYVB2MHVCUTQr?=
 =?utf-8?B?clVWdUZwWGdaR3Q1dHZxbnpWcmwxT01nMVZaMkZSdnZQUndpTitEbkRTS1Zq?=
 =?utf-8?B?a2lYdnc4U0szRmQ0cVdFVXFXQXJ3THlOdlJhY3BldHhmNGZ4TDQ3dkVYbUpL?=
 =?utf-8?B?Z1RPdkpRWkQ3Zmw1L0owNU9ma3M1Tm8zcXludGJHWmVRZ0NsTjZnZkVVSUIw?=
 =?utf-8?B?MFRWa1ptR3Faemw2ekdnSWlVUFhxU3pnNXUwL3JGNENhZ29rMnZOblVkcG1z?=
 =?utf-8?B?Zk9sZjAxYzRERnJyMXF5N29kNUlxNXBHNmQwcFJnM3dtUENHVGlUZndrZXdk?=
 =?utf-8?B?R2FLQmNtMzliOURsUlk3ZmU1Q3dmVkYrSUszMDdxWlFoWW02YmRMVWkxSUM1?=
 =?utf-8?B?V2VXY3E3R283NEp4dkN0WWk1dVF3WnhVWkgybmdDSHRxUmErTmRkc2MzTzFZ?=
 =?utf-8?B?Tk9VV2RrZVQ2RTN6b3ZxdE1zM2tSc3Q1T3l2OEFGbTBiZjJRSjlFMElRbmFn?=
 =?utf-8?B?V1RjVjQ0TTlydmdpUStXenl2WFc4MDd6UDhrWVdWbjEyRFhta0lqSiswcTZt?=
 =?utf-8?B?SG4yU1ArZWFXaVhtREZmL1BDOXk5Q25oREpwNURjdXczNTFKUmlXc3BJdlpG?=
 =?utf-8?B?L3ZSakw2VDBXcVprWThmRzNKMDdGSU1IODBzMEFwTEMzVG5LbDROMFY2YVgw?=
 =?utf-8?B?TGtvOGZQMnVMN0gzckRrUS8rSGYvUFR0RWxqOFZXdXNUWnU0Nnl3TDN3ZWtp?=
 =?utf-8?B?dDB4ZTBqU3M2ekx2aEx5enJncE5rSjVnaUpZb0VLTFpWa3FZcTVtUTF2YzIy?=
 =?utf-8?B?ajBpQzdyNmlzeDdlSldSejNPdG8zL01xR1Q5bks5cElXcWxST0NSUGl6Kys1?=
 =?utf-8?B?UE5TL1pKMDhWL080bE13L0l3c3VkdDQxTzVPODhMbFpFaGliN1pVTjFWM2Yy?=
 =?utf-8?B?VFpvRDF1V24xNkRkekJ0K2QwL01ISGZwQ3JXOFVWS1J6T2d4NGdwYlFPditY?=
 =?utf-8?B?cGV5djRKcWVrZEJlNEhyWStEdDZvMGlqQ09adjRiLy82WS9vWWtNbitWVHYx?=
 =?utf-8?B?cWQ0aVEvbnc1UlZybUVaclg5NEJqeVlrejZZWmErSitydWpUUzlWSUUybXUw?=
 =?utf-8?B?dEttSzVXUEJ4U2dhQ0J6eEZqVzdpcEc4ZWFtYVFKZkduRmptdTZ0T29kUDVU?=
 =?utf-8?B?bHZ2QytFZExodFFwTE5YZC9rWWFDZERnNGQ1RWw1NUJENWlrVEhpaVFMV05R?=
 =?utf-8?B?NXY4R2FBM0JSRHRVNGFKbHpqeTBtanQ1RklCTlBqcUhuSzBDN0QxdXBPc2t6?=
 =?utf-8?Q?txQn2Dw6M+dhDGFGh7/OOF7Obp48u6ZkisycOBnhy1u1?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f0833c23-0d79-4039-1708-08db2626ef8d
X-MS-Exchange-CrossTenant-AuthSource: VI1PR04MB7104.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Mar 2023 14:01:27.4545
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1AmgWoAeEDkgm7cXXJie/t83AZuHrv1kXZ5R23Bbsc49PgogjnaXe/FbV0HFxeCaOuVcgI8jstdZpJziHMbkwg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR04MB7213
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 16.03.23 14:16, Alexander Stein wrote:

> But isn't the root bridge discovered by the driver (pci-imx6 in this case) for
> that? And the driver probe path eventually calls into the sysfs file creation.
> I compared the file creation to usb, as this is a discoverable bus as well.
> There is no special initialization regarding sysfs.

If you discover a bus system you always have the option of creating of virtual
hotplug event for the root hub or host controller.
But for PCI that is a bad design choice. USB is different.

> If, for some reason, the device enumeration for PCI bus during imx6_pcie_probe
> is delayed after pci_sysfs_init initcall, this initcall essentially does
> nothing, no devices or busses to iterate. Which means the complete pcie sysfs

On your specific system. You cannot use that as a model for all systems.

> creation is done from bridge probe path. There is no reason to iterate over
> discovered PCIe devices/busses separately.

If there is no other PCI device, the loop is a nop. But otherwise it is necessary.

>>> So technically the device is not probed from within a initcall but a
>>> kthread. It is set to be probed asynchronous in imx6_pcie_driver.
>>
>> That may be the problem, respectively that system is incomplete
>> You are registering a PCI bridge. The PCI subsystem should be
>> done setting up when you run. That is just a simple dependency.
> 
> Is there such an dependency in the first place? I can't see anything, even the
> late_initcall to pci_resource_alignment_sysfs_init is a different matter.

On your hardware, yes. In the kernel, no.
That is the very point. The kernel is missing a way to represent a dependency.

	Regards
		Oliver

