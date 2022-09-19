Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CBA265BC3FE
	for <lists+linux-pci@lfdr.de>; Mon, 19 Sep 2022 10:07:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229801AbiISIHb (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 19 Sep 2022 04:07:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229754AbiISIH3 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 19 Sep 2022 04:07:29 -0400
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam07on2077.outbound.protection.outlook.com [40.107.212.77])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87A9712A9A
        for <linux-pci@vger.kernel.org>; Mon, 19 Sep 2022 01:07:27 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kEVXP7+kwuMJfhVdVlK7o7ny31u6Cli8uCSXZTTCkTSlWUvy2puqAPBq9NlanU+O5j8exzv63KWKijtLHmfz9NkkL9gednZusW/a7N2d90PahW+UedTJUi6TT/VC6ojFyCZh8gbODj9gFXszPTP9slXeBokVXu3edktj3UpdDCqGNlczNUpxKpGlIfGWUWS75DVpeWR6qbGRoltLCrZfspZ5uI63qCw5YgPfKdnONIcugds5nDpwlqiU3fBtqcJRotBSSKXO2TOFwCM/uaHL2G5pXw/dhqz32BkwWOrjSj6lylZ0izg9nKB0qrPf/y90txDfLm0tkffo/I5xcUqf/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7sUdwoSevOqdJm/4nSB7vRNTtazdiY0sIEgk8myoOds=;
 b=mmbdAdhyq6LizW6Q+636OrKA5qhhrCaA32+GYRR1+1VB2csHLjtD42hYZEJSDgRLZymLmlS47tyHv0HzJ0rM90iwi8x0ZPfK3mdlvFIDFn+gzGO0HgLfgSkGdbg0mD3b9oJd7q9mf65LY7TjRMPTRMucJzs9YU1mtSqFZG8RTctILjy73b7xs5Q2bilns7qVwcTqnvamXMtMIKlVT608UJrhFYppr7iDaj85jPs/c/XIsSRVr6zi6LukdzUcyy0SZ1gg8zUxYy8+3Oc1pC5hqCl1WTyIzMW3ccCCPV51lyGvvLWaMmE9dMb1lfDbh6Ewy/8wuikIdtMdObKW9EmM+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7sUdwoSevOqdJm/4nSB7vRNTtazdiY0sIEgk8myoOds=;
 b=QvYJmRbfk7+zdgWdscK4djAS8zfVkldRul0l+8xu11CuBAniZPPfX+OgZQW4WfUmWHxn0+RXJzAGXc5fS8jO6AAOPxyhpMWq8xuzNStXuSTgzvRD2QCVdTZsozpuxhPu+Iq3c44RH5MeKe2TOPOyKiAB/GieA6du6r1Q1DebbtQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN8PR12MB3587.namprd12.prod.outlook.com (2603:10b6:408:43::13)
 by CY5PR12MB6154.namprd12.prod.outlook.com (2603:10b6:930:26::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5632.17; Mon, 19 Sep
 2022 08:07:25 +0000
Received: from BN8PR12MB3587.namprd12.prod.outlook.com
 ([fe80::653f:e59b:3f40:8fed]) by BN8PR12MB3587.namprd12.prod.outlook.com
 ([fe80::653f:e59b:3f40:8fed%6]) with mapi id 15.20.5632.021; Mon, 19 Sep 2022
 08:07:25 +0000
Message-ID: <727cda96-4c50-c73a-e24a-1b7a18d5bfae@amd.com>
Date:   Mon, 19 Sep 2022 10:07:20 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v2] PCI: Expose PCIe Resizable BAR support via sysfs
Content-Language: en-US
To:     Alex Williamson <alex.williamson@redhat.com>,
        linux-pci@vger.kernel.org
Cc:     =?UTF-8?Q?Krzysztof_Wilczy=c5=84ski?= <kw@linux.com>,
        bhelgaas@google.com
References: <166336088796.3597940.14973499936692558556.stgit@omen>
From:   =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
In-Reply-To: <166336088796.3597940.14973499936692558556.stgit@omen>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR0P281CA0073.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:1e::13) To BN8PR12MB3587.namprd12.prod.outlook.com
 (2603:10b6:408:43::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8PR12MB3587:EE_|CY5PR12MB6154:EE_
X-MS-Office365-Filtering-Correlation-Id: a96b161b-25fc-4df5-bb04-08da9a15fcaf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: LEzP0vtAeJjlMl1JLlaoNalNoqZCKuErEmciYELPFEfA+7rzVSdKI57iFDgkKS03p871ImDk/rESmADeJjcy3NDAqYK6GCRn0urZlaRfSejIM/+tGaW+epJWoNppsjCAYMKLDr7HVXFU5ykCRSzpompXBH8Bvmm2AUb8aeUr+mgm21Gi/vI3qVbUXuW5xrs0GWao1Rj20flbm9fq32v1+hg96E89Wv5sJa6zk9qCs9TyYbiP6Nwpk8G8HqmXYIsWShWsU0Oi1KktH4wM3YqURjPTbQq579nkUbUWfiBLm34vCtt152n+d59/jqeeKdBaYuX80uAMLTLmnxag9cVqKrMTPpg+vBISrnh2Wxl3qL/f2JB7XbCCvPlDYiltf+gQVy84ADMLWPW9xIDuaUAXF26+j/IrAJICtf5AqXBeCzHD8OM2UOC8Bd2qfQaO4F97l/fcNXYagGtmfft0a6MFwwf++DNbeUBT+D8C9hZ2zv3PCrmPzaxfrDWEXX3hNdYL2qboVBlH2ejQxlRLQGNiDKvq7kmkCuVL+x8Ane1ccc+U+afJXXB8B26SgMbvd7vFMFYTYWsLAdX62b/aB1EHRbBdKz3JIjRKxgsq5HYO71Wxf/jnEm6+xXq5SNb93Pr5CCxdv66UnjWvuHizkvObtux8X/rpSpMRFDEiz/jLdeN7f0wRRIe9qAyTzFRRFYgF/mlFTNud+eBNbdgALw/XOnRJKKX3YVHJUZrBoFTYg8hL4cU7xpeOkKzl3VJ0ZMYqdr7jhsqumSGG39S66NQ7O/LvLNyKO7V4DzvKtvZw/aI=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN8PR12MB3587.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(366004)(136003)(39860400002)(346002)(376002)(396003)(451199015)(478600001)(6486002)(6506007)(41300700001)(6666004)(38100700002)(8936002)(2906002)(5660300002)(36756003)(31696002)(66556008)(316002)(66476007)(86362001)(8676002)(4326008)(66946007)(31686004)(83380400001)(2616005)(6512007)(26005)(186003)(66574015)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OVIvd2daTURKb284SFNhN3RXb1krakVHWm5mUldUVXFZQ3ZMc09xWXAvak45?=
 =?utf-8?B?S0hQZDJyc1M1OU5HREsrUU1qa1R3Tm8xeUU3OGkxZHpsWnd3N1g1VDN3MnYr?=
 =?utf-8?B?OERHQ0hrVXNEOElVUDRkZXpvVjF3Z1ZVT2plNEtBRTV3OWlXUTdlczB0ZGl3?=
 =?utf-8?B?eTBhS21IbThiaEJEVlNTQnFlZTFJdlp6WUdJTmNqM3hTZnMzWG1QR2JkWHl4?=
 =?utf-8?B?c0h0a2xuREdhQUpKa3FWTHdzTytaMDcyNm9FczVVazY1ay93SHhmc2VkWWRj?=
 =?utf-8?B?aVV5eUwrRStzNS91cFlNeEpsdHFPT25wZEhESnBLckZMczFpNzhWTWZnUlJ6?=
 =?utf-8?B?MU04MTJyYkJpS2R2dFRmRVdjZExvTVg0Vi9NVFhTd0VHTjBDL2NzNEJna0di?=
 =?utf-8?B?ekNDSjFOMTdWa0FHSE52T082UU5TVzJWbm53bVJpcGwwZm52M1hpU2Y1cDlD?=
 =?utf-8?B?dVE5U2ZpbUgzemlueERPbmNoVVl3T3paaGZwbjhjUXJrUUJFRDRxdXNjQXgx?=
 =?utf-8?B?OGV6aERWdUhqVzlUVnZJUnRtYUo0SFFRSUs2bk1wUEo2YzR1TnBTK1poemlq?=
 =?utf-8?B?dHhBbEhURlltZUwzODM4dXBCcFY3QmY3eDRqWCt6cG95U29zOCtKdmo3OG82?=
 =?utf-8?B?dWdoSll0bDZ2a2ZKZm1VZWgvTTZRMi9lY3Q4T0xlVUZZNFJjamxoTXZYK3ov?=
 =?utf-8?B?ZzJObm5iTlV2Nlprb2N3SDNmQzY1Q3dzUnZxSWtmRUNuVy9IeGRaZHVpL3JI?=
 =?utf-8?B?Yk00bk50RkptWnp6dlBtVENQTDR1MWlVZVRsN1k5c2VhOGQ0ZHF1dFRiN1N1?=
 =?utf-8?B?ZjZqZEhQMUIyenZDZHgya2xSUHlaYUNjTlh6cWpBQmZxTWZMejJKZkxYSis2?=
 =?utf-8?B?aWkxUTlCU0hhbzFYZVNxa0FVZlMxZTJRTWEwaDIrekVaRWtCUlJwZTZYM2Nm?=
 =?utf-8?B?SmNoVitoOHZGSmlBRVBLeVY3M0tsbTRxcEY1STJVMHZQNFpvR2RZbGdvcWFm?=
 =?utf-8?B?K2o2Y2Rsb1lIekdPZ3JIZzdnb2RVNHFnQ0pGZW9kcm1UTlVqQVBCNDRxaHlE?=
 =?utf-8?B?OFg3bVZkNlovVkJVbjJmQ2dIV0xHKzZKNG5nb1hBZDVqb01jSTdOWHZJeXBt?=
 =?utf-8?B?WmNqaFhyY1hKbGs1UEZoakRlVGF0bzJZdENWUm1qMnpJMTZpZytoYkp5cUdH?=
 =?utf-8?B?WU5oZzdZZTUxZTZ0dTZjU2NtWExadVMvZ1VBdnMyck5EbHY4M0pzTjE1cjM4?=
 =?utf-8?B?bXRlM0l4VWxZRVl0Tm11RUY5L3Vnci8rWHFaL1FrL3Z2SnpsaTljODQzOW8y?=
 =?utf-8?B?YUlTL3Y2RDlVQ3hvT2JBNjRTVnJuN3ZFSExQN1g0eFdUTTBEajNoRmgzc0Zo?=
 =?utf-8?B?ZXBNVFNyTVJ2Sy9PaEsxYTU3anE1cWxOR1YxeE5hUEZOZllweXhyTEdldDVI?=
 =?utf-8?B?SGE2bitFZmxrTGdReFdnajkvc0RlOER4YWhKalEwL1JvSjd2TVl4NlB1REpn?=
 =?utf-8?B?dVljcTRLU2FHNjBxTUdyZ05EZVlGSGJ4c1VpaHBiNkZUaGVBRzRqSGtZNU5U?=
 =?utf-8?B?bCsrQUs5eHFKeWFqM1J6ZHpuWEI4REhpVUdVdUVmcFE0ME9RdVRwa0EyVVIr?=
 =?utf-8?B?Um9NWHc0SnBrSTN1R0s2Vmt6TU9NbytRRkVBSVRIVERWb25VaFMxMDBwV2Jy?=
 =?utf-8?B?YjAxaUgxOFBKV3haQzZiTFVBZFhpamp2WGNRUDhIWGRsMUZiT3hRRy82VHQ4?=
 =?utf-8?B?Z3UrN3JLR0V4MVZOTnBBaU9FNFZVQ0NPUEkycythbnB6dnRoWE1KNWJFM2Fs?=
 =?utf-8?B?WG1mYUZZdVdaZzdLRlVlbURsQmN6YWRxUjhURE41TG9SN0U2SU9od0lVUkZ0?=
 =?utf-8?B?azJEVUF1MWNCeFlTbGVpVUlVQks2M3BUYTFUVmJWQ1NGTEFDVGVBTjlHazMz?=
 =?utf-8?B?WHpYYVRlN0s3K2xKQmdUWWNFQW9mSHpmN1ppd3VCSjNhSW8rSUZuWUlVbnhG?=
 =?utf-8?B?RHFHYXNZTHprckdoZEtuNEsvOGd4YUo0S1c2TE5oWG83M2JFRHZsTjY0YmFR?=
 =?utf-8?B?UXhQaTF0VWpmVXc5Znd1QXFYSHJOcFo2TkFvSkFQVjgzZWxPaVNWNC9FR01w?=
 =?utf-8?Q?bxYDlWwbHLeTUqcmuqpH+tsO0?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a96b161b-25fc-4df5-bb04-08da9a15fcaf
X-MS-Exchange-CrossTenant-AuthSource: BN8PR12MB3587.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Sep 2022 08:07:25.1806
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TBKlEgPs0b1qpB96gK03tKX1vUmNN5nG8t+Yb3BXqQ45q9xY/mZo9VKc5HJnUy1f
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6154
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Am 16.09.22 um 22:44 schrieb Alex Williamson:
> This proposes a simple sysfs interface to Resizable BAR support,
> largely for the purposes of assigning such devices to a VM through
> VFIO.  Resizable BARs present a difficult feature to expose to a VM
> through emulation, as resizing a BAR is done on the host.  It can
> fail, and often does, but we have no means via emulation of a PCIe
> REBAR capability to handle the error cases.
>
> A vfio-pci specific ioctl interface is also cumbersome as there are
> often multiple devices within the same bridge aperture and handling
> them is a challenge.  In the interface proposed here, expanding a
> BAR potentially requires such devices to be soft-removed during the
> resize operation and rescanned after, in order for all the necessary
> resources to be released.  A pci-sysfs interface is also more
> universal than a vfio specific interface.
>
> Please see the ABI documentation update for usage.
>
> Cc: Christian König <christian.koenig@amd.com>
> Cc: Krzysztof Wilczyński <kw@linux.com>
> Signed-off-by: Alex Williamson <alex.williamson@redhat.com>

I'm not an expert for that sysfs stuff, but the rest looks totally sane 
to me.

Reviewed-by: Christian König <christian.koenig@amd.com>

> ---
>
> v2:
>   - Convert to static attributes with is_visible callback
>   - Include aperture driver removal for console drivers
>   - Remove and recreate resourceN attributes
>   - Expand ABI description
>   - Drop 2nd field in show attribute
>
>   Documentation/ABI/testing/sysfs-bus-pci |   33 +++++++++
>   drivers/pci/pci-sysfs.c                 |  108 +++++++++++++++++++++++++++++++
>   2 files changed, 141 insertions(+)
>
> diff --git a/Documentation/ABI/testing/sysfs-bus-pci b/Documentation/ABI/testing/sysfs-bus-pci
> index 6fc2c2efe8ab..ba9a5482436f 100644
> --- a/Documentation/ABI/testing/sysfs-bus-pci
> +++ b/Documentation/ABI/testing/sysfs-bus-pci
> @@ -457,3 +457,36 @@ Description:
>   
>   		The file is writable if the PF is bound to a driver that
>   		implements ->sriov_set_msix_vec_count().
> +
> +What:		/sys/bus/pci/devices/.../resourceN_resize
> +Date:		September 2022
> +Contact:	Alex Williamson <alex.williamson@redhat.com>
> +Description:
> +		These files provide an interface to PCIe Resizable BAR support.
> +		A file is created for each BAR resource (N) supported by the
> +		PCIe Resizable BAR extended capability of the device.  Reading
> +		each file exposes the bitmap of available resources sizes:
> +
> +		# cat resource1_resize
> +		00000000000001c0
> +
> +		The bitmap represents supported resources sizes for the BAR,
> +		where bit0 = 1MB, bit1 = 2MB, bit2 = 4MB, etc.  In the above
> +		example the devices supports 64MB, 128MB, and 256MB BAR sizes.
> +
> +		When writing the file, the user provides the bit position of
> +		the desired resource size, for example:
> +
> +		# echo 7 > resource1_resize
> +
> +		This indicates to set the size value corresponding to bit 7,
> +		128MB.  The resulting size is 2 ^ (bit# + 20).  This definition
> +		matches the PCIe specification of this capability.
> +
> +		In order to make use of resouce resizing, all PCI drivers must
> +		be unbound from the device and peer devices under the same
> +		parent bridge may need to be soft removed.  In the case of
> +		VGA devices, writing a resize value will remove low level
> +		console drivers from the device.  Raw users of pci-sysfs
> +		resourceN attributes must be terminated prior to resizing.
> +		Success of the resizing operation is not a guaranteed.
> diff --git a/drivers/pci/pci-sysfs.c b/drivers/pci/pci-sysfs.c
> index 9ac92e6a2397..f0298a8b08d9 100644
> --- a/drivers/pci/pci-sysfs.c
> +++ b/drivers/pci/pci-sysfs.c
> @@ -28,6 +28,7 @@
>   #include <linux/pm_runtime.h>
>   #include <linux/msi.h>
>   #include <linux/of.h>
> +#include <linux/aperture.h>
>   #include "pci.h"
>   
>   static int sysfs_initialized;	/* = 0 */
> @@ -1379,6 +1380,112 @@ static const struct attribute_group pci_dev_reset_attr_group = {
>   	.is_visible = pci_dev_reset_attr_is_visible,
>   };
>   
> +#define pci_dev_resource_resize_attr(n)					\
> +static ssize_t resource##n##_resize_show(struct device *dev,		\
> +					 struct device_attribute *attr,	\
> +					 char * buf)			\
> +{									\
> +	struct pci_dev *pdev = to_pci_dev(dev);				\
> +	ssize_t ret;							\
> +									\
> +	pci_config_pm_runtime_get(pdev);				\
> +									\
> +	ret = sysfs_emit(buf, "%016llx\n",				\
> +			 (u64)pci_rebar_get_possible_sizes(pdev, n));	\
> +									\
> +	pci_config_pm_runtime_put(pdev);				\
> +									\
> +	return ret;							\
> +}									\
> +									\
> +static ssize_t resource##n##_resize_store(struct device *dev,		\
> +					  struct device_attribute *attr,\
> +					  const char *buf, size_t count)\
> +{									\
> +	struct pci_dev *pdev = to_pci_dev(dev);				\
> +	unsigned long size, flags;					\
> +	int ret, i;							\
> +	u16 cmd;							\
> +									\
> +	if (kstrtoul(buf, 0, &size) < 0)				\
> +		return -EINVAL;						\
> +									\
> +	device_lock(dev);						\
> +	if (dev->driver) {						\
> +		ret = -EBUSY;						\
> +		goto unlock;						\
> +	}								\
> +									\
> +	pci_config_pm_runtime_get(pdev);				\
> +									\
> +	if ((pdev->class >> 8) == PCI_CLASS_DISPLAY_VGA) {		\
> +		ret = aperture_remove_conflicting_pci_devices(pdev,	\
> +						"resourceN_resize");	\
> +		if (ret)						\
> +			goto pm_put;					\
> +	}								\
> +									\
> +	pci_read_config_word(pdev, PCI_COMMAND, &cmd);			\
> +	pci_write_config_word(pdev, PCI_COMMAND,			\
> +			      cmd & ~PCI_COMMAND_MEMORY);		\
> +									\
> +	flags = pci_resource_flags(pdev, n);				\
> +									\
> +	pci_remove_resource_files(pdev);				\
> +									\
> +	for (i = 0; i < PCI_STD_NUM_BARS; i++) {			\
> +		if (pci_resource_len(pdev, i) &&			\
> +		    pci_resource_flags(pdev, i) == flags)		\
> +			pci_release_resource(pdev, i);			\
> +	}								\
> +									\
> +	ret = pci_resize_resource(pdev, n, size);			\
> +									\
> +	pci_assign_unassigned_bus_resources(pdev->bus);			\
> +									\
> +	if (pci_create_resource_files(pdev))				\
> +		pci_warn(pdev, "Failed to recreate resource files after BAR resizing\n");\
> +									\
> +	pci_write_config_word(pdev, PCI_COMMAND, cmd);			\
> +pm_put:									\
> +	pci_config_pm_runtime_put(pdev);				\
> +unlock:									\
> +	device_unlock(dev);						\
> +									\
> +	return ret ? ret : count;					\
> +}									\
> +static DEVICE_ATTR_RW(resource##n##_resize)
> +
> +pci_dev_resource_resize_attr(0);
> +pci_dev_resource_resize_attr(1);
> +pci_dev_resource_resize_attr(2);
> +pci_dev_resource_resize_attr(3);
> +pci_dev_resource_resize_attr(4);
> +pci_dev_resource_resize_attr(5);
> +
> +static struct attribute *resource_resize_attrs[] = {
> +	&dev_attr_resource0_resize.attr,
> +	&dev_attr_resource1_resize.attr,
> +	&dev_attr_resource2_resize.attr,
> +	&dev_attr_resource3_resize.attr,
> +	&dev_attr_resource4_resize.attr,
> +	&dev_attr_resource5_resize.attr,
> +	NULL,
> +};
> +
> +static umode_t resource_resize_is_visible(struct kobject *kobj,
> +					  struct attribute *a, int n)
> +{
> +	struct pci_dev *pdev = to_pci_dev(kobj_to_dev(kobj));
> +
> +	return pci_rebar_get_current_size(pdev, n) < 0 ? 0 : a->mode;
> +}
> +
> +static const struct attribute_group pci_dev_resource_resize_group = {
> +	.attrs = resource_resize_attrs,
> +	.is_visible = resource_resize_is_visible,
> +};
> +
>   int __must_check pci_create_sysfs_dev_files(struct pci_dev *pdev)
>   {
>   	if (!sysfs_initialized)
> @@ -1500,6 +1607,7 @@ const struct attribute_group *pci_dev_groups[] = {
>   #ifdef CONFIG_ACPI
>   	&pci_dev_acpi_attr_group,
>   #endif
> +	&pci_dev_resource_resize_group,
>   	NULL,
>   };
>   
>
>

