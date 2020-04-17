Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1C7F51ADC0D
	for <lists+linux-pci@lfdr.de>; Fri, 17 Apr 2020 13:18:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730168AbgDQLRG (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 17 Apr 2020 07:17:06 -0400
Received: from mail-eopbgr30076.outbound.protection.outlook.com ([40.107.3.76]:56814
        "EHLO EUR03-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729962AbgDQLRE (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 17 Apr 2020 07:17:04 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Tnuf2KCDtP8dn1TjLP4yb03VINfDkQw4S3Rre7BBhFTNpuGym+0dJK7fTiZFnqnInHL4FC2DAuWXJL7eNBpYKZQe+5yQHNntZXD/k1hMQ0fjy/fNu7sjQGeNrmTYyl0/G1co/kRGSVtl1+esGMfjOSQG9LysDTBxosPaNRImr3hlRayD+4fRy4hxO2py1jbHkzJ7jknddvylNpdxMN0TbMK7e4199yfLZNW0pXjJ7HqMjAZV19yVOZ++wFy16exA9EvbDBKHGMbVmZnjDGR4u5lLgCiuAPCZ6pD77uWxoVEaLPrLAvs58OyK3TIwCKDmwxhrQZvQu3ppt5aAs7k1+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AVzt+Jap4TJfLXF14y13Esm1BBIwj8GvOQo2EQLi4pg=;
 b=EQWfNn4kIrjscy55rr4N5kIQOJm2Z+NNPVMCRbUpkdHscVESN/g8pZn7V4vgekxkLVBaIG9vkK42QYMYxs1w9UaXfD45g0tS+Y2F/qh0ZomB9J3G2qIreA7LPVcu3pagA0OcP4uHOPcSRidXi5TreQ4XI96uB7LAOoWnQhdLCQpI46ph6ef4x7wOk+ort5AVejq12uYgxeC9xoweln1wnECrNfeLrhpLzkA3ll6EbPYIkVdBCCJzwHbBxKwmr0V7/d/+K9GvqRJ5stKsV8CXNuNBY0MlUlHqw6d8WtydnVT4buNdQxBwdlBtRlSpAw0U7cb5c/dFNWr4icTwnMRceA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mellanox.com; dmarc=pass action=none header.from=mellanox.com;
 dkim=pass header.d=mellanox.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AVzt+Jap4TJfLXF14y13Esm1BBIwj8GvOQo2EQLi4pg=;
 b=ITJ3FB4Eb6vXl8FchqVGyoUtoDMMZC8xzyBrzsgUh61MQY3ZwLWCfAXa6gNclurBBemTqNeZ5hnveSIYRBKDTiWlplZrOtOqL2rxBg+Vke3MmCyqiv4Dt5OBdbFO4Vmee/oD78agTZc1W3pISkKbScQeKRvLNMCmZ+I0Kk6EAg8=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=maxg@mellanox.com; 
Received: from AM0PR05MB5810.eurprd05.prod.outlook.com (2603:10a6:208:11f::18)
 by AM0PR05MB4484.eurprd05.prod.outlook.com (2603:10a6:208:62::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2900.15; Fri, 17 Apr
 2020 11:17:00 +0000
Received: from AM0PR05MB5810.eurprd05.prod.outlook.com
 ([fe80::408a:27c1:55f8:eed4]) by AM0PR05MB5810.eurprd05.prod.outlook.com
 ([fe80::408a:27c1:55f8:eed4%5]) with mapi id 15.20.2900.028; Fri, 17 Apr 2020
 11:17:00 +0000
Subject: Re: [PATCH 2/2] powerpc/powernv: Enable and setup PCI P2P
To:     Christoph Hellwig <hch@lst.de>
Cc:     linux-pci@vger.kernel.org, fbarrat@linux.ibm.com,
        clsoto@us.ibm.com, idanw@mellanox.com, aneela@mellanox.com,
        shlomin@mellanox.com
References: <20200416165725.206741-1-maxg@mellanox.com>
 <20200416165725.206741-2-maxg@mellanox.com> <20200417070238.GC18880@lst.de>
From:   Max Gurtovoy <maxg@mellanox.com>
Message-ID: <7255b11a-4ea0-3bac-2cc3-7fff0b56c9ac@mellanox.com>
Date:   Fri, 17 Apr 2020 14:16:49 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
In-Reply-To: <20200417070238.GC18880@lst.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-ClientProxiedBy: AM4PR0101CA0060.eurprd01.prod.exchangelabs.com
 (2603:10a6:200:41::28) To AM0PR05MB5810.eurprd05.prod.outlook.com
 (2603:10a6:208:11f::18)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [10.0.0.3] (217.132.177.164) by AM4PR0101CA0060.eurprd01.prod.exchangelabs.com (2603:10a6:200:41::28) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2921.27 via Frontend Transport; Fri, 17 Apr 2020 11:16:59 +0000
X-Originating-IP: [217.132.177.164]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: de8f1a53-362c-44e7-6623-08d7e2c0d938
X-MS-TrafficTypeDiagnostic: AM0PR05MB4484:|AM0PR05MB4484:|AM0PR05MB4484:
X-LD-Processed: a652971c-7d2e-4d9b-a6a4-d149256f461b,ExtAddr
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM0PR05MB4484E90BDEF7B7E792C7681CB6D90@AM0PR05MB4484.eurprd05.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
X-Forefront-PRVS: 0376ECF4DD
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR05MB5810.eurprd05.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(10009020)(4636009)(396003)(376002)(136003)(366004)(346002)(39860400002)(5660300002)(2616005)(956004)(316002)(31686004)(4326008)(6486002)(186003)(8676002)(107886003)(81156014)(16526019)(6916009)(478600001)(6666004)(26005)(66556008)(66946007)(52116002)(53546011)(66476007)(86362001)(2906002)(16576012)(31696002)(8936002)(36756003);DIR:OUT;SFP:1101;
Received-SPF: None (protection.outlook.com: mellanox.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: wrrMpcGFdO7/EpAwyipFAypcVpp/c4E9xDq14ZIvRNyL68x3CG/ve5RfzfxOeok0dO/iihThZo3u3oIt8JaWpjATC2a3lHLAOvzY1gJI34onz58h5ULNiDOm+E2l86xqKWjpxlDIoqPoLVG58d7h7pQP62tkGFoH1X5G6a5FgSmNxVZu2WLM8ijGefjzz3Cd7aBxXTJ67Rez/qChIj190vKKiLlrPzLKBZ70m5Upso9yW89twmkunLO/UhO9P21SWgKCZOqudfDmWXod+8LZS4J/HtxWmP7qKGCc32yIqHqHkO2uTmj6YAEoibQtgjTdc7ASl+0iL9LrDdfm7WEomSomVFZApV6pj98Uu03nzYDwz1E/PecQPMU3dzRVOK8q/WXG6H1rPNLogy5vob5XO0pKNsf9y397xC/blY5sKGBq0JryRH2gVhWXwR+HkQU2
X-MS-Exchange-AntiSpam-MessageData: nQqKz4yo6H2z+KTVJZURz6vmpUceOsc/ocuP2hv/LyOGshtfWJb8ElSmU2hlKoCjHMmBUG9Rw+iSjBw135ixHqwQpUd0/q93cKainWytWpKTXZuBVetSpTHXpnHEuNx6BR2+8qb3/J+EkmT/ET6Ctw==
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-Network-Message-Id: de8f1a53-362c-44e7-6623-08d7e2c0d938
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Apr 2020 11:17:00.3683
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Yk2glKH1+uZWXMHryVLdETU0i2QT9neQmPcXOp0LojCl46Xzk2vHfaUtMTqWOl4b8DJ+UECF6RvMHNFv2nRu9Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR05MB4484
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org


On 4/17/2020 10:02 AM, Christoph Hellwig wrote:
>> +#ifdef CONFIG_PCI_P2PDMA
>> +int64_t opal_pci_set_p2p(uint64_t phb_init, uint64_t phb_target,
>> +			 uint64_t desc, uint16_t pe_number);
>> +#endif
> There should be no need for the ifdef here.
>
>> +	/*
>> +	 * Configuring the initiator's PHB requires to adjust its
>> +	 * TVE#1 setting. Since the same device can be an initiator
>> +	 * several times for different target devices, we need to keep
>> +	 * a reference count to know when we can restore the default
>> +	 * bypass setting on its TVE#1 when disabling. Opal is not
>> +	 * tracking PE states, so we add a reference count on the PE
>> +	 * in linux.
>> +	 *
>> +	 * For the target, the configuration is per PHB, so we keep a
>> +	 * target reference count on the PHB.
>> +	 */
> This could be shortened a bit by using up the whole 80 lines available
> in source files.
>
>> +	mutex_lock(&p2p_mutex);
>> +
>> +	if (desc & OPAL_PCI_P2P_ENABLE) {
>> +		/* always go to opal to validate the configuration */
>> +		rc = opal_pci_set_p2p(phb_init->opal_id, phb_target->opal_id,
>> +				      desc, pe_init->pe_number);
>> +
>> +		if (rc != OPAL_SUCCESS) {
>> +			rc = -EIO;
>> +			goto out;
>> +		}
>> +
>> +		pe_init->p2p_initiator_count++;
>> +		phb_target->p2p_target_count++;
>> +	} else {
>> +		if (!pe_init->p2p_initiator_count ||
>> +		    !phb_target->p2p_target_count) {
>> +			rc = -EINVAL;
>> +			goto out;
>> +		}
>> +
>> +		if (--pe_init->p2p_initiator_count == 0)
>> +			pnv_pci_ioda2_set_bypass(pe_init, true);
>> +
>> +		if (--phb_target->p2p_target_count == 0) {
>> +			rc = opal_pci_set_p2p(phb_init->opal_id,
>> +					      phb_target->opal_id, desc,
>> +					      pe_init->pe_number);
>> +			if (rc != OPAL_SUCCESS) {
>> +				rc = -EIO;
>> +				goto out;
>> +			}
>> +		}
>> +	}
>> +	rc = 0;
>> +out:
>> +	mutex_unlock(&p2p_mutex);
>> +	return rc;
>> +}
> The enable and disable path shares almost no code, why not split it into
> two functions?

how about also changing the defines OPAL_PCI_P2P_* to an enum ?

/* PCI p2p operation descriptors */
enum opal_pci_p2p {

         OPAL_PCI_P2P_DISABLE    = 0,

         OPAL_PCI_P2P_ENABLE     = (1 << 0),
         OPAL_PCI_P2P_LOAD       = (1 << 1),
         OPAL_PCI_P2P_STORE      = (1 << 2),
};

Fred ?


>> +static bool pnv_pci_controller_owns_addr(struct pci_controller *hose,
>> +					 phys_addr_t addr, size_t size)
>> +{
>> +	struct resource *r;
>> +	int i;
>> +
>> +	/*
>> +	 * it seems safe to assume the full range is under the same
>> +	 * PHB, so we can ignore the size
> Capitalize the first character in a multi-line comment, and use up the
> whole 80 chars.
>
>> +	 */
>> +	for (i = 0; i < 3; i++) {
> Replace the magic 3 with ARRAY_SIZE(hose->mem_resources) ?
>
>
>> +		r = &hose->mem_resources[i];
> Move the r declaration here and initialize it on the same line.
>
>> +		if (r->flags && (addr >= r->start) && (addr < r->end))
> No need for the inner braces.
>
>> +			return true;
>> +	}
>> +	return false;
>> +}
>> +
>> +/*
>> + * find the phb owning a mmio address if not owned locally
>> + */
>> +static struct pnv_phb *pnv_pci_find_owning_phb(struct pci_dev *pdev,
>> +					       phys_addr_t addr, size_t size)
>> +{
>> +	struct pci_controller *hose = pci_bus_to_host(pdev->bus);
>> +	struct pnv_phb *phb;
>> +
>> +	/* fast path */
>> +	if (pnv_pci_controller_owns_addr(hose, addr, size))
>> +		return NULL;
> Maybe open code the pci_bus_to_host(pdev->bus) call here, as we just
> overwrite host in the list iteration?

if this is more readable so no problem:

if (pnv_pci_controller_owns_addr(pdev->bus->sysdata, addr, size))


>
>> +
>> +	list_for_each_entry(hose, &hose_list, list_node) {
>> +		phb = hose->private_data;
> Move the ohb declaration here and initialize it on the same line.
>
>> +		if (phb->type != PNV_PHB_NPU_NVLINK &&
>> +		    phb->type != PNV_PHB_NPU_OCAPI) {
>> +			if (pnv_pci_controller_owns_addr(hose, addr, size))
>> +				return phb;
>> +		}
>> +	}
>
>> +	return NULL;
>> +}
>> +
>> +static int pnv_pci_dma_map_resource(struct pci_dev *pdev,
>> +				    phys_addr_t phys_addr, size_t size,
>> +				    enum dma_data_direction dir)
>> +{
>> +	struct pnv_phb *target_phb;
>> +	int rc;
>> +	u64 desc;
>> +
>> +	target_phb = pnv_pci_find_owning_phb(pdev, phys_addr, size);
>> +	if (target_phb) {
> Return early here for the !target_phb case?
>
>> +		desc = OPAL_PCI_P2P_ENABLE;
>> +		if (dir == DMA_TO_DEVICE)
>> +			desc |= OPAL_PCI_P2P_STORE;
>> +		else if (dir == DMA_FROM_DEVICE)
>> +			desc |= OPAL_PCI_P2P_LOAD;
>> +		else if (dir == DMA_BIDIRECTIONAL)
>> +			desc |= OPAL_PCI_P2P_LOAD | OPAL_PCI_P2P_STORE;
> Seems like this could be split into a little helper.

sure.


>
>> +		rc = pnv_pci_ioda_set_p2p(pdev, target_phb, desc);
>> +		if (rc) {
>> +			dev_err(&pdev->dev, "Failed to setup PCI peer-to-peer for address %llx: %d\n",
>> +				phys_addr, rc);
>> +			return rc;
>> +		}
> No need for this printk, the callers should already deal with mapping
> failures.
>
