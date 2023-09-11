Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E0AA279B383
	for <lists+linux-pci@lfdr.de>; Tue, 12 Sep 2023 02:00:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237864AbjIKVhy (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 11 Sep 2023 17:37:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243830AbjIKRx1 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 11 Sep 2023 13:53:27 -0400
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD5AEDD;
        Mon, 11 Sep 2023 10:53:22 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ecxj+zMmjY/HvGShvryJTqaI0Hs3Lc1iCpENL0B4uHWgY1Zh/d73Tw9eHNGpKXRlGSieoiK7ffwTxFatgPemk5XC6V8fjaSL+TpSfTKFRKUIB3xLsU6r5VYE6Jb5N70C2EKGHcxsMHtBAyxnI4tqDWZrhwn/fC1V/q9ekceinzxYtWPCD9cobnRHTlpJvnhq79c66SNZtORX1gaq++1QAiwjwWdXrSHDlJcQBTOANyx2S32yNc5E/oCLBJ/9RAHKNrD6IO44JL+60XWYiYVK8HHDkUZrEwURTdnp/F+GMKgeYrdAJv1DGrY7iZu+zOz1XrmwQFjjF9r+gRnJP8AXOg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=I27CdA9nGIjjkUPqrkXDOeQckuPZX9UDZHmF4o7dkg0=;
 b=aV7K/K65y6dTMrMPzjDlFaaejyQQZHtxZrFaanPN0zW0vzeilF5PAn40hVkGd5X693d3t4SV3R85zTlllZHvI09WEwsmTYm6X74idDOmTrkjeQW0tJE2gP992wKAL7hfLroEN3p3M3N93BAL6s/dTkl52XCgES7gPUYw7pAqpVF+GH+W6MgruovINmFqRyBPQeuI7xefmJmyKZ1MZEqJ2glGXutg6sPivFegDoXVcuNhASRc4QPvGPrMjnOTD/Oo4NTTP2rDtO1XUp1pPAw2XwaM6eXxZ+0oHhzwSEYiheB5QCj/XOY3ptgGzgR6nXG7cFIPhsP0oL4W5Hh+JsSsJg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=bootlin.com smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=I27CdA9nGIjjkUPqrkXDOeQckuPZX9UDZHmF4o7dkg0=;
 b=u9KlbuOGq2UvjW4NEjKj9KZ2rZbR5rov87RiFzdsbsp15r1+OJrg+yib/qixtzhp57q7E/gsN7zv5hi6nuV1SR2oZyd3yhUBE76PLxL4OkSvCs9yrlXCoYSj9Xb6DHxEAbq9HNk6unl4dIEl1lqUu3eS70oQW7u/YrvM/veW2Xk=
Received: from CY5PR13CA0011.namprd13.prod.outlook.com (2603:10b6:930::16) by
 BL3PR12MB6572.namprd12.prod.outlook.com (2603:10b6:208:38f::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6768.30; Mon, 11 Sep
 2023 17:53:20 +0000
Received: from CY4PEPF0000FCBF.namprd03.prod.outlook.com
 (2603:10b6:930:0:cafe::84) by CY5PR13CA0011.outlook.office365.com
 (2603:10b6:930::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.16 via Frontend
 Transport; Mon, 11 Sep 2023 17:53:20 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CY4PEPF0000FCBF.mail.protection.outlook.com (10.167.242.101) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6792.16 via Frontend Transport; Mon, 11 Sep 2023 17:53:19 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Mon, 11 Sep
 2023 12:53:18 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Mon, 11 Sep
 2023 12:53:18 -0500
Received: from [172.19.74.144] (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.27 via Frontend
 Transport; Mon, 11 Sep 2023 12:53:17 -0500
Message-ID: <4ccd9525-455d-3608-dd39-caf2753620c1@amd.com>
Date:   Mon, 11 Sep 2023 10:53:17 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH V13 2/5] PCI: Create device tree node for bridge
Content-Language: en-US
To:     Herve Codina <herve.codina@bootlin.com>
CC:     <linux-pci@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <robh@kernel.org>,
        <max.zhen@amd.com>, <sonal.santan@amd.com>,
        <stefano.stabellini@xilinx.com>
References: <1692120000-46900-1-git-send-email-lizhi.hou@amd.com>
 <1692120000-46900-3-git-send-email-lizhi.hou@amd.com>
 <20230911171319.495bb837@bootlin.com>
From:   Lizhi Hou <lizhi.hou@amd.com>
In-Reply-To: <20230911171319.495bb837@bootlin.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000FCBF:EE_|BL3PR12MB6572:EE_
X-MS-Office365-Filtering-Correlation-Id: 557140f8-d229-4494-1e22-08dbb2effbc7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: o2v7awokjMN3F8H/nlfq2iHYyRwtgFgS+lqFYXWCpYh1PPup0nGL3Q5qBnVOhLuu/DxWaK7P9NbTERVs8/YZALbyTtC5cn6mPzp4fNWQm1bHB5XlgGuYsb1lLQiaUc75iSEsxvwlNGpUEcEdLyjzAi00whc+MS102T9jgD/a2cqNbGxBys7OwqpFOqrNU7nyzWKuvdJmfNIW2dWiIrrUFqQHx2bVroONUl+K8pg4EdWm03MGofyZkO2TTdFcFYLSodsXyNC0pYtAazZiGKxvjWV2QqzulOUIC0hSmoGFmpFFAjPqIFExfZPHV2cUpkCNYG5vCLwCDPz6dSZ6fNmmol+aVDKWyTHG6taMRVcdu0vIrD8kmB3T+lZTkjWw4cDqdSpP/wT7WHirVb6Dwscz4+fntFXmBVedgshDCkdW20sJ9kRA7Zuf5VQe2bEFVkec9KfyQyx2wkqf5kVPuhIbWSRmVgjfCBSc0Usa2KfYpYwGK2jehX6RacBu1P5+7DN1zifcP/JOqT5IFT2C3JhXJuGMTYPP/favgn+Id1rUTVpt+/Ak8gwjFH8EkoyDEjMXUwfC+TrPFks8J7mK3dYpze1LzDoIF1VcevCDGAtyZ8W7DwR5KRTtS/si5SKRtY4Bba8KShidcPxccSnD3VAQEX4ItKXM5BF3L4p7VrLxDzrP7nV+cUc/phQUXRxb+tvn42xyRXckNWiZvzykTQ+L/VYt6sgmj68BoyMOyLOF3yUDAMsKT8rO7O8SAu5aC9uOq4B1gEp0fzg2TzRdWlrztMBVLEzI2SW996jIX8oPknkoz/v0m8ngrq/cr5mmqNGo
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(39860400002)(346002)(136003)(396003)(376002)(1800799009)(451199024)(82310400011)(186009)(46966006)(36840700001)(40470700004)(44832011)(5660300002)(31686004)(4326008)(8936002)(8676002)(41300700001)(316002)(70586007)(70206006)(6916009)(54906003)(478600001)(2906002)(53546011)(16576012)(2616005)(26005)(426003)(336012)(36860700001)(47076005)(83380400001)(356005)(81166007)(82740400003)(31696002)(40460700003)(36756003)(40480700001)(86362001)(43740500002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Sep 2023 17:53:19.3021
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 557140f8-d229-4494-1e22-08dbb2effbc7
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000FCBF.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR12MB6572
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org


On 9/11/23 08:13, Herve Codina wrote:
> Hi Lizhi,
>
> On Tue, 15 Aug 2023 10:19:57 -0700
> Lizhi Hou <lizhi.hou@amd.com> wrote:
> ...
>> +void of_pci_make_dev_node(struct pci_dev *pdev)
>> +{
>> +	struct device_node *ppnode, *np = NULL;
>> +	const char *pci_type;
>> +	struct of_changeset *cset;
>> +	const char *name;
>> +	int ret;
>> +
>> +	/*
>> +	 * If there is already a device tree node linked to this device,
>> +	 * return immediately.
>> +	 */
>> +	if (pci_device_to_OF_node(pdev))
>> +		return;
>> +
>> +	/* Check if there is device tree node for parent device */
>> +	if (!pdev->bus->self)
>> +		ppnode = pdev->bus->dev.of_node;
>> +	else
>> +		ppnode = pdev->bus->self->dev.of_node;
>> +	if (!ppnode)
>> +		return;
>> +
>> +	if (pci_is_bridge(pdev))
>> +		pci_type = "pci";
>> +	else
>> +		pci_type = "dev";
>> +
>> +	name = kasprintf(GFP_KERNEL, "%s@%x,%x", pci_type,
>> +			 PCI_SLOT(pdev->devfn), PCI_FUNC(pdev->devfn));
>> +	if (!name)
>> +		return;
>> +
>> +	cset = kmalloc(sizeof(*cset), GFP_KERNEL);
>> +	if (!cset)
>> +		goto failed;
>> +	of_changeset_init(cset);
>> +
>> +	np = of_changeset_create_node(ppnode, name, cset);
>> +	if (!np)
>> +		goto failed;
> The "goto failed" will leak the cset previously allocated.
>
> np->data = cset; (next line) allows to free the cset when the node is destroyed
> (of_node_put() calls). When the node cannot be created, the allocated cset should
> be freed.
Thanks for pointing this out.
>
>> +	np->data = cset;
>> +
>> +	ret = of_pci_add_properties(pdev, cset, np);
>> +	if (ret)
>> +		goto failed;
>> +
>> +	ret = of_changeset_apply(cset);
>> +	if (ret)
>> +		goto failed;
>> +
>> +	pdev->dev.of_node = np;
>> +	kfree(name);
>> +
>> +	return;
>> +
>> +failed:
>> +	if (np)
>> +		of_node_put(np);
>> +	kfree(name);
>> +}
>> +#endif
>> +
>>   #endif /* CONFIG_PCI */
>>   
> ...
>> +static int of_pci_prop_intr_map(struct pci_dev *pdev, struct of_changeset *ocs,
>> +				struct device_node *np)
>> +{
>> +	struct of_phandle_args out_irq[OF_PCI_MAX_INT_PIN];
>> +	u32 i, addr_sz[OF_PCI_MAX_INT_PIN], map_sz = 0;
>> +	__be32 laddr[OF_PCI_ADDRESS_CELLS] = { 0 };
>> +	u32 int_map_mask[] = { 0xffff00, 0, 0, 7 };
>> +	struct device_node *pnode;
>> +	struct pci_dev *child;
>> +	u32 *int_map, *mapp;
>> +	int ret;
>> +	u8 pin;
>> +
>> +	pnode = pci_device_to_OF_node(pdev->bus->self);
>> +	if (!pnode)
>> +		pnode = pci_bus_to_OF_node(pdev->bus);
>> +
>> +	if (!pnode) {
>> +		pci_err(pdev, "failed to get parent device node");
>> +		return -EINVAL;
>> +	}
>> +
>> +	laddr[0] = cpu_to_be32((pdev->bus->number << 16) | (pdev->devfn << 8));
>> +	for (pin = 1; pin <= OF_PCI_MAX_INT_PIN;  pin++) {
>> +		i = pin - 1;
>> +		out_irq[i].np = pnode;
>> +		out_irq[i].args_count = 1;
>> +		out_irq[i].args[0] = pin;
>> +		ret = of_irq_parse_raw(laddr, &out_irq[i]);
>> +		if (ret) {
>> +			pci_err(pdev, "parse irq %d failed, ret %d", pin, ret);
>> +			continue;
>> +		}
>> +		ret = of_property_read_u32(out_irq[i].np, "#address-cells",
>> +					   &addr_sz[i]);
>> +		if (ret)
>> +			addr_sz[i] = 0;
>> +	}
> if of_irq_parse_raw() fails, addr_sz[i] is not initialized and map_sz bellow is
> computed with uninitialized values.
> On the test I did, this lead to a kernel crash due to the following kcalloc()
> called with incorrect values.
>
> Are interrupt-map and interrupt-map-mask properties needed in all cases ?
> I mean are they mandatory for the host pci bridge ?
interrupt-map is required for bridges when a legacy interrupt device is 
underneath. Otherwise, of_irq_parse_pci() needs to be changed for legacy 
interrupt device. Please see my previous patch and comments.
>
>> +
>> +	list_for_each_entry(child, &pdev->subordinate->devices, bus_list) {
>> +		for (pin = 1; pin <= OF_PCI_MAX_INT_PIN; pin++) {
>> +			i = pci_swizzle_interrupt_pin(child, pin) - 1;
>> +			map_sz += 5 + addr_sz[i] + out_irq[i].args_count;
> of_irq_parse_raw() can fail on some pins.
> Is it correct to set map_sz based on information related to all pins even if
> of_irq_parse_raw() previously failed on some pins ?

I think the interrupt-map pair should be skipped if of_irq_parse_raw() 
is failed. Thanks.


Lizhi

>
>> +		}
>> +	}
>> +
>> +	int_map = kcalloc(map_sz, sizeof(u32), GFP_KERNEL);
>> +	mapp = int_map;
>> +
>> +	list_for_each_entry(child, &pdev->subordinate->devices, bus_list) {
>> +		for (pin = 1; pin <= OF_PCI_MAX_INT_PIN; pin++) {
>> +			*mapp = (child->bus->number << 16) |
>> +				(child->devfn << 8);
>> +			mapp += OF_PCI_ADDRESS_CELLS;
>> +			*mapp = pin;
>> +			mapp++;
>> +			i = pci_swizzle_interrupt_pin(child, pin) - 1;
>> +			*mapp = out_irq[i].np->phandle;
>> +			mapp++;
>> +			if (addr_sz[i]) {
>> +				ret = of_property_read_u32_array(out_irq[i].np,
>> +								 "reg", mapp,
>> +								 addr_sz[i]);
>> +				if (ret)
>> +					goto failed;
>> +			}
>> +			mapp += addr_sz[i];
>> +			memcpy(mapp, out_irq[i].args,
>> +			       out_irq[i].args_count * sizeof(u32));
>> +			mapp += out_irq[i].args_count;
>> +		}
>> +	}
>> +
>> +	ret = of_changeset_add_prop_u32_array(ocs, np, "interrupt-map", int_map,
>> +					      map_sz);
>> +	if (ret)
>> +		goto failed;
>> +
>> +	ret = of_changeset_add_prop_u32(ocs, np, "#interrupt-cells", 1);
>> +	if (ret)
>> +		goto failed;
>> +
>> +	ret = of_changeset_add_prop_u32_array(ocs, np, "interrupt-map-mask",
>> +					      int_map_mask,
>> +					      ARRAY_SIZE(int_map_mask));
>> +	if (ret)
>> +		goto failed;
>> +
>> +	kfree(int_map);
>> +	return 0;
>> +
>> +failed:
>> +	kfree(int_map);
>> +	return ret;
>> +}
>> +
> ...
>
> Regards,
> Hervé
>
