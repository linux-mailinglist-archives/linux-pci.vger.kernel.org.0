Return-Path: <linux-pci+bounces-35863-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 98244B5277E
	for <lists+linux-pci@lfdr.de>; Thu, 11 Sep 2025 06:15:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 53F0A7A59FB
	for <lists+linux-pci@lfdr.de>; Thu, 11 Sep 2025 04:13:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 210EC329F3E;
	Thu, 11 Sep 2025 04:15:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TTeUgwFO"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E57BA329F24;
	Thu, 11 Sep 2025 04:15:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757564131; cv=none; b=X5khx3B8GivecvI1K+SU5/itezmYk5xRVOyEsBtVkWVmxySoE6uYmL5rK1jU7kbr7B14vU7rX2yskzjrMgudzb2Q9hXLE+1Ly7SDeQJUGWS/PQ81ERGVpufagpmIuSMEYfvNLFz8LBrrLYBDH94q4hhermMVKPcqTmITaW1oCEM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757564131; c=relaxed/simple;
	bh=pl5ztVqBzotyrP88+BDm0jks7M0I/AiqLdfl9ck2p/k=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=JdfAIolii6zrVKTMFoise2kp8bnL5wJGJoMZCz440ef2ZoyyfdnE8s70rnsZtm+n+7tw0JtxSheI2wr5+x1JwInpDMjEoO9vY+yv7QEJRZxhavMPX7aJs3Q45GgRshcrwBGHRzChfsqFrzl8mWl68MRY2/wzIXwS0LaSH1U401Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TTeUgwFO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C2857C4CEF1;
	Thu, 11 Sep 2025 04:15:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757564130;
	bh=pl5ztVqBzotyrP88+BDm0jks7M0I/AiqLdfl9ck2p/k=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=TTeUgwFOPtv3ZMu+mJOoPgDZN5SsYcBckCJNNhamVhbOuydkrvqjRH5zCQbd8Omaz
	 0BmT7pB6ASwwowzocmtmLZCMAIOI+dBGPwINDh2XSHufQ4vs3zgaP04vyvEB0PXqrb
	 snneQN7qUTxr7VrRnJ1lngRe3UARe9u8eJ1x/oDW7x4Idpf7si8M4e9qBAw6h/HVfG
	 zxJ2zLd6eRk2leo7bKwn+X2gn+9x/Ix+bMHdr9Gq+6kiGuLKRMACBJM2CA/41AOPeU
	 zmDVevDlfC7W77RYIW11dvDf9ESJ7cyTWAFkLDiO22C84vvqHNMFh3YI6ilckslNP7
	 nE1NqLXMKJReQ==
X-Mailer: emacs 30.2 (via feedmail 11-beta-1 I)
From: Aneesh Kumar K.V <aneesh.kumar@kernel.org>
To: Arto Merilainen <amerilainen@nvidia.com>, dan.j.williams@intel.com
Cc: linux-kernel@vger.kernel.org, bhelgaas@google.com, aik@amd.com,
	lukas@wunner.de, Samuel Ortiz <sameo@rivosinc.com>,
	Yilun Xu <yilun.xu@linux.intel.com>, linux-pci@vger.kernel.org,
	linux-coco@lists.linux.dev
Subject: Re: [PATCH v4 07/10] PCI/IDE: Add IDE establishment helpers
In-Reply-To: <yq5azfbjq2nf.fsf@kernel.org>
References: <20250717183358.1332417-1-dan.j.williams@intel.com>
 <20250717183358.1332417-8-dan.j.williams@intel.com>
 <9683c850-3152-4da5-97f1-3e86ba39e8d3@nvidia.com>
 <6896333756c9f_184e1f100ef@dwillia2-xfh.jf.intel.com.notmuch>
 <21903f51-1ed0-41a4-a8c8-cfa78ce6093d@nvidia.com>
 <yq5azfbjq2nf.fsf@kernel.org>
Date: Thu, 11 Sep 2025 09:45:22 +0530
Message-ID: <yq5a1pod4obp.fsf@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Aneesh Kumar K.V <aneesh.kumar@kernel.org> writes:

> Arto Merilainen <amerilainen@nvidia.com> writes:
>
>> On 8.8.2025 20.26, dan.j.williams@intel.com wrote:
>>> Arto Merilainen wrote:
>>>> The first revision of this patch had address association register
>>>> programming but it has since been removed. Could you comment if there is
>>>> a reason for this change?
>>> 
>>> We chatted about it around this point in the original review thread [1].
>>> tl;dr SEV-TIO and TDX Connect did not see a strict need for it. However,
>>> the expectation was always to circle back and revive it if it turned out
>>> later to be required.
>>
>> Thank you for the reference. I suppose it is ok to rely on the default 
>> streams on the first iteration, and add a follow-up patch in the ARM CCA 
>> device assignment support series in case it is the only architecture 
>> that depends on them.
>>
>>> 
>>>> Some background: This might be problematic for ARM CCA. I recall seeing
>>>> a comment stating that the address association register programming can
>>>> be skipped on some architectures (e.g., apparently AMD uses a separate
>>>> table that contains the StreamID) but on ARM CCA the StreamID
>>>> association AFAIK happens through these registers.
>>> 
>>> Can you confirm and perhaps work with Aneesh to propose an incremental
>>> patch to add that support back? It might be something that we let the
>>> low level TSM driver control. Like an additional address association
>>> object that can be attached to 'struct pci_ide' by the low level TSM
>>> driver.
>>
>> Aneesh, could you perhaps extend the IDE driver by adding the RP address 
>> association register programming in the next revision of the DA support 
>> series?
>>
>
> Sure, I can add that change as part of next update. 
>

This is the change I am adding

 drivers/pci/ide.c                        | 128 ++++++++++++++++++++++-
 drivers/virt/coco/arm-cca-host/arm-cca.c |  13 +++
 include/linux/pci-ide.h                  |   7 ++
 3 files changed, 147 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/ide.c b/drivers/pci/ide.c
index 3f772979eacb..23d1712ba97a 100644
--- a/drivers/pci/ide.c
+++ b/drivers/pci/ide.c
@@ -101,7 +101,7 @@ void pci_ide_init(struct pci_dev *pdev)
 	pdev->ide_cap = ide_cap;
 	pdev->nr_link_ide = nr_link_ide;
 	pdev->nr_sel_ide = nr_streams;
-	pdev->nr_ide_mem = nr_ide_mem;
+	pdev->nr_ide_mem = min(nr_ide_mem, PCI_IDE_AASOC_REG_MAX);
 }
 
 struct stream_index {
@@ -213,11 +213,13 @@ struct pci_ide *pci_ide_stream_alloc(struct pci_dev *pdev)
 				.rid_start = pci_dev_id(rp),
 				.rid_end = pci_dev_id(rp),
 				.stream_index = no_free_ptr(ep_stream)->stream_index,
+				.nr_mem = 0,
 			},
 			[PCI_IDE_RP] = {
 				.rid_start = pci_dev_id(pdev),
 				.rid_end = rid_end,
 				.stream_index = no_free_ptr(rp_stream)->stream_index,
+				.nr_mem = 0,
 			},
 		},
 		.host_bridge_stream = no_free_ptr(hb_stream)->stream_index,
@@ -228,6 +230,109 @@ struct pci_ide *pci_ide_stream_alloc(struct pci_dev *pdev)
 }
 EXPORT_SYMBOL_GPL(pci_ide_stream_alloc);
 
+static int add_range_merge_overlap(struct range *range, int az, int nr_range,
+				   u64 start, u64 end)
+{
+	int i;
+
+	if (start >= end)
+		return nr_range;
+
+	/* get new start/end: */
+	for (i = 0; i < nr_range; i++) {
+
+		if (!range[i].end)
+			continue;
+
+		/* Try to add to the end */
+		if (range[i].end + 1 == start) {
+			range[i].end = end;
+			return nr_range;
+		}
+
+		/* Try to add to the start */
+		if (range[i].start == end + 1) {
+			range[i].start = start;
+			return nr_range;
+		}
+	}
+
+	/* Need to add it: */
+	return add_range(range, az, nr_range, start, end);
+}
+
+int pci_ide_add_address_assoc_block(struct pci_dev *pdev,
+				    struct pci_ide *ide,
+				    u64 start, u64 end)
+{
+	struct pci_ide_partner *partner;
+
+	if (!pci_is_pcie(pdev)) {
+		pci_warn_once(pdev, "not a PCIe device\n");
+		return -EINVAL;
+	}
+
+	switch (pci_pcie_type(pdev)) {
+	case PCI_EXP_TYPE_ENDPOINT:
+
+		if (pdev != ide->pdev)
+			return -EINVAL;
+		partner = &ide->partner[PCI_IDE_RP];
+		break;
+	default:
+		pci_warn_once(pdev, "invalid device type\n");
+		return -EINVAL;
+	}
+
+	if (partner->nr_mem >= pdev->nr_ide_mem)
+		return -ENOMEM;
+
+	partner->nr_mem = add_range_merge_overlap(partner->mem,
+					   PCI_IDE_AASOC_REG_MAX, partner->nr_mem,
+					   start, end);
+	return 0;
+}
+
+
+int pci_ide_merge_address_assoc_block(struct pci_dev *pdev,
+				      struct pci_ide *ide, u64 start, u64 end)
+{
+	struct pci_ide_partner *partner;
+
+	if (!pci_is_pcie(pdev)) {
+		pci_warn_once(pdev, "not a PCIe device\n");
+		return -EINVAL;
+	}
+
+	switch (pci_pcie_type(pdev)) {
+	case PCI_EXP_TYPE_ENDPOINT:
+
+		if (pdev != ide->pdev)
+			return -EINVAL;
+		partner = &ide->partner[PCI_IDE_RP];
+		break;
+	default:
+		pci_warn_once(pdev, "invalid device type\n");
+		return -EINVAL;
+	}
+
+	for (int i = 0; i < PCI_IDE_AASOC_REG_MAX; i++) {
+		struct range *r = &partner->mem[i];
+
+		if (r->start < start)
+			start = r->start;
+		if (r->end > end)
+			end = r->end;
+		r->start = 0;
+		r->end = 0;
+	}
+	partner->mem[0].start = start;
+	partner->mem[0].end = end;
+	partner->nr_mem = 1;
+
+	return 0;
+}
+
 /**
  * pci_ide_stream_free() - unwind pci_ide_stream_alloc()
  * @ide: idle IDE settings descriptor
@@ -424,6 +529,21 @@ void pci_ide_stream_setup(struct pci_dev *pdev, struct pci_ide *ide)
 
 	pci_write_config_dword(pdev, pos + PCI_IDE_SEL_RID_2, val);
 
+	for (int i = 0; i < settings->nr_mem; i++) {
+		val = FIELD_PREP(PCI_IDE_SEL_ADDR_1_VALID, 1) |
+			FIELD_PREP(PCI_IDE_SEL_ADDR_1_BASE_LOW,
+				   lower_32_bits(settings->mem[i].start)) |
+			FIELD_PREP(PCI_IDE_SEL_ADDR_1_LIMIT_LOW,
+				   lower_32_bits(settings->mem[i].end));
+		pci_write_config_dword(pdev, pos + PCI_IDE_SEL_ADDR_1(i), val);
+
+		val = upper_32_bits(settings->mem[i].end);
+		pci_write_config_dword(pdev, pos + PCI_IDE_SEL_ADDR_2(i), val);
+
+		val = upper_32_bits(settings->mem[i].start);
+		pci_write_config_dword(pdev, pos + PCI_IDE_SEL_ADDR_3(i), val);
+	}
+
 	/*
 	 * Setup control register early for devices that expect
 	 * stream_id is set during key programming.
@@ -453,6 +573,12 @@ void pci_ide_stream_teardown(struct pci_dev *pdev, struct pci_ide *ide)
 	pos = sel_ide_offset(pdev, settings);
 
 	pci_write_config_dword(pdev, pos + PCI_IDE_SEL_CTL, 0);
+	for (int i = settings->nr_mem - 1; i >= 0; i--) {
+		pci_write_config_dword(pdev, pos + PCI_IDE_SEL_ADDR_3(i), 0);
+		pci_write_config_dword(pdev, pos + PCI_IDE_SEL_ADDR_2(i), 0);
+		pci_write_config_dword(pdev, pos + PCI_IDE_SEL_ADDR_1(i), 0);
+	}
+
 	pci_write_config_dword(pdev, pos + PCI_IDE_SEL_RID_2, 0);
 	pci_write_config_dword(pdev, pos + PCI_IDE_SEL_RID_1, 0);
 	settings->setup = 0;
diff --git a/drivers/virt/coco/arm-cca-host/arm-cca.c b/drivers/virt/coco/arm-cca-host/arm-cca.c
index c9717698af56..28993f9277e4 100644
--- a/drivers/virt/coco/arm-cca-host/arm-cca.c
+++ b/drivers/virt/coco/arm-cca-host/arm-cca.c
@@ -137,6 +137,7 @@ static int cca_tsm_connect(struct pci_dev *pdev)
 {
 	struct pci_dev *rp = pcie_find_root_port(pdev);
 	struct cca_host_pf0_dsc *dsc_pf0;
+	struct resource *res;
 	struct pci_ide *ide;
 	int rc, stream_id;
 
@@ -163,9 +164,21 @@ static int cca_tsm_connect(struct pci_dev *pdev)
 	if (rc)
 		goto err_stream;
 
+	/*
+	 * Try to use the available address assoc register blocks.
+	 * If we fail with ENOMEM, create one block covering the entire
+	 * address range. (Should work for arm64)
+	 */
+	pci_dev_for_each_resource(pdev, res) {
+		rc = pci_ide_add_address_assoc_block(pdev, ide, res->start, res->end);
+		if (rc == -ENOMEM)
+			pci_ide_merge_address_assoc_block(pdev, ide, res->start, res->end);
+	}
+
 	pci_ide_stream_setup(pdev, ide);
 	pci_ide_stream_setup(rp, ide);
 
+
 	rc = tsm_ide_stream_register(ide);
 	if (rc)
 		goto err_tsm;
diff --git a/include/linux/pci-ide.h b/include/linux/pci-ide.h
index c3838d11af88..3d4f7f462a8d 100644
--- a/include/linux/pci-ide.h
+++ b/include/linux/pci-ide.h
@@ -19,6 +19,7 @@ enum pci_ide_partner_select {
 	PCI_IDE_HB = PCI_IDE_PARTNER_MAX,
 };
 
+#define PCI_IDE_AASOC_REG_MAX	6
 /**
  * struct pci_ide_partner - Per port pair Selective IDE Stream settings
  * @rid_start: Partner Port Requester ID range start
@@ -34,6 +35,8 @@ struct pci_ide_partner {
 	u8 stream_index;
 	unsigned int setup:1;
 	unsigned int enable:1;
+	int nr_mem;
+	struct range mem[PCI_IDE_AASOC_REG_MAX];
 };
 
 /**
@@ -60,6 +63,10 @@ struct pci_ide {
 
 struct pci_ide_partner *pci_ide_to_settings(struct pci_dev *pdev, struct pci_ide *ide);
 struct pci_ide *pci_ide_stream_alloc(struct pci_dev *pdev);
+int pci_ide_add_address_assoc_block(struct pci_dev *pdev,
+				    struct pci_ide *ide, u64 start, u64 end);
+int pci_ide_merge_address_assoc_block(struct pci_dev *pdev,
+				      struct pci_ide *ide, u64 start, u64 end);
 void pci_ide_stream_free(struct pci_ide *ide);
 int  pci_ide_stream_register(struct pci_ide *ide);
 void pci_ide_stream_unregister(struct pci_ide *ide);
-- 
2.43.0


