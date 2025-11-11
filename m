Return-Path: <linux-pci+bounces-40880-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B258C4D7A2
	for <lists+linux-pci@lfdr.de>; Tue, 11 Nov 2025 12:48:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 0FCD034DC5C
	for <lists+linux-pci@lfdr.de>; Tue, 11 Nov 2025 11:48:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF9A4338929;
	Tue, 11 Nov 2025 11:47:58 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 945F628FFF6;
	Tue, 11 Nov 2025 11:47:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762861678; cv=none; b=Zl3+P7k4comgnhYY7ODvjmUXNyxEHbeo+A7UDL61hodyhhSsAskRaRtl7PyabTP7R2KqPGHQq0ofAKwbWCGg8/wvb8VCz/LMyAUFuA0nlMCTEb2Yk8JEIz7ihCNpkC6mJMsdwa0Z9Cl1Jz+TtFVRGrXKYbL820LfUo+ySpXNPu0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762861678; c=relaxed/simple;
	bh=MlD0iJSQI+O269B3HASFJ++0ifmSrVl185Z1gP0RY4w=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TP3Gk87GLal5Do/QPAEvSlpOlFnNr1fWxoQ1IXUyp7DnauLaVg62+YUeZeldpXa/lhRxZxIlg7zmIvGzlPwwhMkrTaQuawt1z1795tDFsQKOXS5SGw1aV86wK68JldociekRJ0MMLCBN6qvNCkrNpUAEy5UXhY9wimZvS0IMpRQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.231])
	by frasgout.his.huawei.com (SkyGuard) with ESMTPS id 4d5PsX6jJqzHnGdS;
	Tue, 11 Nov 2025 19:47:28 +0800 (CST)
Received: from dubpeml100005.china.huawei.com (unknown [7.214.146.113])
	by mail.maildlp.com (Postfix) with ESMTPS id E19BB14033C;
	Tue, 11 Nov 2025 19:47:45 +0800 (CST)
Received: from localhost (10.203.177.15) by dubpeml100005.china.huawei.com
 (7.214.146.113) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.36; Tue, 11 Nov
 2025 11:47:44 +0000
Date: Tue, 11 Nov 2025 11:47:42 +0000
From: Jonathan Cameron <jonathan.cameron@huawei.com>
To: Alexey Kardashevskiy <aik@amd.com>
CC: <linux-kernel@vger.kernel.org>, <linux-crypto@vger.kernel.org>,
	<linux-pci@vger.kernel.org>, Tom Lendacky <thomas.lendacky@amd.com>, "John
 Allen" <john.allen@amd.com>, Herbert Xu <herbert@gondor.apana.org.au>, "David
 S. Miller" <davem@davemloft.net>, Ashish Kalra <ashish.kalra@amd.com>, Joerg
 Roedel <joro@8bytes.org>, "Suravee Suthikulpanit"
	<suravee.suthikulpanit@amd.com>, Will Deacon <will@kernel.org>, Robin Murphy
	<robin.murphy@arm.com>, Dan Williams <dan.j.williams@intel.com>, Bjorn
 Helgaas <bhelgaas@google.com>, "Eric Biggers" <ebiggers@google.com>, Brijesh
 Singh <brijesh.singh@amd.com>, "Gary R Hook" <gary.hook@amd.com>, "Borislav
 Petkov (AMD)" <bp@alien8.de>, "Kim Phillips" <kim.phillips@amd.com>, Vasant
 Hegde <vasant.hegde@amd.com>, "Jason Gunthorpe" <jgg@ziepe.ca>, Michael Roth
	<michael.roth@amd.com>, Xu Yilun <yilun.xu@linux.intel.com>, Gao Shiyuan
	<gaoshiyuan@baidu.com>, "Sean Christopherson" <seanjc@google.com>, Nikunj A
 Dadhania <nikunj@amd.com>, Dionna Glaze <dionnaglaze@google.com>,
	<iommu@lists.linux.dev>, <linux-coco@lists.linux.dev>
Subject: Re: [PATCH kernel 6/6] crypto/ccp: Implement SEV-TIO PCIe IDE
 (phase1)
Message-ID: <20251111114742.00007cd8@huawei.com>
In-Reply-To: <20251111063819.4098701-7-aik@amd.com>
References: <20251111063819.4098701-1-aik@amd.com>
	<20251111063819.4098701-7-aik@amd.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml100010.china.huawei.com (7.191.174.197) To
 dubpeml100005.china.huawei.com (7.214.146.113)

On Tue, 11 Nov 2025 17:38:18 +1100
Alexey Kardashevskiy <aik@amd.com> wrote:

> Implement the SEV-TIO (Trusted I/O) firmware interface for PCIe TDISP
> (Trust Domain In-Socket Protocol). This enables secure communication
> between trusted domains and PCIe devices through the PSP (Platform
> Security Processor).
> 
> The implementation includes:
> - Device Security Manager (DSM) operations for establishing secure links
> - SPDM (Security Protocol and Data Model) over DOE (Data Object Exchange)
> - IDE (Integrity Data Encryption) stream management for secure PCIe
> 
> This module bridges the SEV firmware stack with the generic PCIe TSM
> framework.
> 
> This is phase1 as described in Documentation/driver-api/pci/tsm.rst.
> 
> On AMD SEV, the AMD PSP firmware acts as TSM (manages the security/trust).
> The CCP driver provides the interface to it and registers in the TSM
> subsystem.
> 
> Implement SEV TIO PSP command wrappers in sev-dev-tio.c and store
> the data in the SEV-TIO-specific structs.
> 
> Implement TSM hooks and IDE setup in sev-dev-tsm.c.
> 
> Signed-off-by: Alexey Kardashevskiy <aik@amd.com>
Hi Alexey,

Various minor comments inline.

Thanks,

Jonathan

> diff --git a/drivers/crypto/ccp/sev-dev-tio.h b/drivers/crypto/ccp/sev-dev-tio.h
> new file mode 100644
> index 000000000000..c72ac38d4351
> --- /dev/null
> +++ b/drivers/crypto/ccp/sev-dev-tio.h

> diff --git a/drivers/crypto/ccp/sev-dev-tio.c b/drivers/crypto/ccp/sev-dev-tio.c
> new file mode 100644
> index 000000000000..ca0db6e64839
> --- /dev/null
> +++ b/drivers/crypto/ccp/sev-dev-tio.c

> +static size_t sla_dobj_id_to_size(u8 id)
> +{
> +	size_t n;
> +
> +	BUILD_BUG_ON(sizeof(struct spdm_dobj_hdr_resp) != 0x10);
> +	switch (id) {
> +	case SPDM_DOBJ_ID_REQ:
> +		n = sizeof(struct spdm_dobj_hdr_req);
> +		break;
> +	case SPDM_DOBJ_ID_RESP:
> +		n = sizeof(struct spdm_dobj_hdr_resp);
> +		break;
> +	default:
> +		WARN_ON(1);
> +		n = 0;
> +		break;
> +	}
> +
> +	return n;

Maybe just returning above would be simpler and remove need for local variables
etc.

> +}
>
> + * struct sev_data_tio_dev_connect - TIO_DEV_CONNECT
> + *
> + * @length: Length in bytes of this command buffer.
> + * @spdm_ctrl: SPDM control structure defined in Section 5.1.
> + * @device_id: The PCIe Routing Identifier of the device to connect to.
> + * @root_port_id: The PCIe Routing Identifier of the root port of the device

A few of these aren't present in the structure so out of date docs I think

> + * @segment_id: The PCIe Segment Identifier of the device to connect to.
> + * @dev_ctx_sla: Scatter list address of the device context buffer.
> + * @tc_mask: Bitmask of the traffic classes to initialize for SEV-TIO usage.
> + *           Setting the kth bit of the TC_MASK to 1 indicates that the traffic
> + *           class k will be initialized.
> + * @cert_slot: Slot number of the certificate requested for constructing the SPDM session.
> + * @ide_stream_id: IDE stream IDs to be associated with this device.
> + *                 Valid only if corresponding bit in TC_MASK is set.
> + */
> +struct sev_data_tio_dev_connect {
> +	u32 length;
> +	u32 reserved1;
> +	struct spdm_ctrl spdm_ctrl;
> +	u8 reserved2[8];
> +	struct sla_addr_t dev_ctx_sla;
> +	u8 tc_mask;
> +	u8 cert_slot;
> +	u8 reserved3[6];
> +	u8 ide_stream_id[8];
> +	u8 reserved4[8];
> +} __packed;
> +
> +/**
> + * struct sev_data_tio_dev_disconnect - TIO_DEV_DISCONNECT
> + *
> + * @length: Length in bytes of this command buffer.
> + * @force: Force device disconnect without SPDM traffic.
> + * @spdm_ctrl: SPDM control structure defined in Section 5.1.
> + * @dev_ctx_sla: Scatter list address of the device context buffer.
> + */
> +struct sev_data_tio_dev_disconnect {
> +	u32 length;
> +	union {
> +		u32 flags;
> +		struct {
> +			u32 force:1;
> +		};
> +	};
> +	struct spdm_ctrl spdm_ctrl;
> +	struct sla_addr_t dev_ctx_sla;
> +} __packed;
> +
> +/**
> + * struct sev_data_tio_dev_meas - TIO_DEV_MEASUREMENTS
> + *
> + * @length: Length in bytes of this command buffer

flags need documentation as well.
Generally I'd avoid bitfields and rely on defines so we don't hit
the weird stuff the c spec allows to be done with bitfields.

> + * @raw_bitstream: 0: Requests the digest form of the attestation report
> + *                 1: Requests the raw bitstream form of the attestation report
> + * @spdm_ctrl: SPDM control structure defined in Section 5.1.
> + * @dev_ctx_sla: Scatter list address of the device context buffer.
> + */
> +struct sev_data_tio_dev_meas {
> +	u32 length;
> +	union {
> +		u32 flags;
> +		struct {
> +			u32 raw_bitstream:1;
> +		};
> +	};
> +	struct spdm_ctrl spdm_ctrl;
> +	struct sla_addr_t dev_ctx_sla;
> +	u8 meas_nonce[32];
> +} __packed;

> +/**
> + * struct sev_data_tio_dev_reclaim - TIO_DEV_RECLAIM command
> + *
> + * @length: Length in bytes of this command buffer
> + * @dev_ctx_paddr: SPA of page donated by hypervisor
> + */
> +struct sev_data_tio_dev_reclaim {
> +	u32 length;
> +	u32 reserved;
Why a u32 for this reserved, but u8[] arrays for some of thos in
other structures like sev_data_tio_asid_fence_status.
I'd aim for consistency on that. I don't really mind which option!
> +	struct sla_addr_t dev_ctx_sla;
> +} __packed;
> +
> +/**
> + * struct sev_data_tio_asid_fence_clear - TIO_ASID_FENCE_CLEAR command
> + *
> + * @length: Length in bytes of this command buffer
> + * @dev_ctx_paddr: Scatter list address of device context
> + * @gctx_paddr: System physical address of guest context page

As below wrt to complete docs.

> + *
> + * This command clears the ASID fence for a TDI.
> + */
> +struct sev_data_tio_asid_fence_clear {
> +	u32 length;				/* In */
> +	u32 reserved1;
> +	struct sla_addr_t dev_ctx_paddr;	/* In */
> +	u64 gctx_paddr;			/* In */
> +	u8 reserved2[8];
> +} __packed;
> +
> +/**
> + * struct sev_data_tio_asid_fence_status - TIO_ASID_FENCE_STATUS command
> + *
> + * @length: Length in bytes of this command buffer
Kernel-doc complains about undocument structure elements, so you probably have
to add a trivial comment for the two reserved ones to keep it happy.

> + * @dev_ctx_paddr: Scatter list address of device context
> + * @asid: Address Space Identifier to query
> + * @status_pa: System physical address where fence status will be written
> + *
> + * This command queries the fence status for a specific ASID.
> + */
> +struct sev_data_tio_asid_fence_status {
> +	u32 length;				/* In */
> +	u8 reserved1[4];
> +	struct sla_addr_t dev_ctx_paddr;	/* In */
> +	u32 asid;				/* In */
> +	u64 status_pa;
> +	u8 reserved2[4];
> +} __packed;
> +
> +static struct sla_buffer_hdr *sla_buffer_map(struct sla_addr_t sla)
> +{
> +	struct sla_buffer_hdr *buf;
> +
> +	BUILD_BUG_ON(sizeof(struct sla_buffer_hdr) != 0x40);
> +	if (IS_SLA_NULL(sla))
> +		return NULL;
> +
> +	if (sla.page_type == SLA_PAGE_TYPE_SCATTER) {
> +		struct sla_addr_t *scatter = sla_to_va(sla);
> +		unsigned int i, npages = 0;
> +		struct page **pp;
> +
> +		for (i = 0; i < SLA_SCATTER_LEN(sla); ++i) {
> +			if (WARN_ON_ONCE(SLA_SZ(scatter[i]) > SZ_4K))
> +				return NULL;
> +
> +			if (WARN_ON_ONCE(scatter[i].page_type == SLA_PAGE_TYPE_SCATTER))
> +				return NULL;
> +
> +			if (IS_SLA_EOL(scatter[i])) {
> +				npages = i;
> +				break;
> +			}
> +		}
> +		if (WARN_ON_ONCE(!npages))
> +			return NULL;
> +
> +		pp = kmalloc_array(npages, sizeof(pp[0]), GFP_KERNEL);

Could use a __free to avoid needing to manually clean this up.

> +		if (!pp)
> +			return NULL;
> +
> +		for (i = 0; i < npages; ++i)
> +			pp[i] = sla_to_page(scatter[i]);
> +
> +		buf = vm_map_ram(pp, npages, 0);
> +		kfree(pp);
> +	} else {
> +		struct page *pg = sla_to_page(sla);
> +
> +		buf = vm_map_ram(&pg, 1, 0);
> +	}
> +
> +	return buf;
> +}

> +
> +/* Expands a buffer, only firmware owned buffers allowed for now */
> +static int sla_expand(struct sla_addr_t *sla, size_t *len)
> +{
> +	struct sla_buffer_hdr *oldbuf = sla_buffer_map(*sla), *newbuf;
> +	struct sla_addr_t oldsla = *sla, newsla;
> +	size_t oldlen = *len, newlen;
> +
> +	if (!oldbuf)
> +		return -EFAULT;
> +
> +	newlen = oldbuf->capacity_sz;
> +	if (oldbuf->capacity_sz == oldlen) {
> +		/* This buffer does not require expansion, must be another buffer */
> +		sla_buffer_unmap(oldsla, oldbuf);
> +		return 1;
> +	}
> +
> +	pr_notice("Expanding BUFFER from %ld to %ld bytes\n", oldlen, newlen);
> +
> +	newsla = sla_alloc(newlen, true);
> +	if (IS_SLA_NULL(newsla))
> +		return -ENOMEM;
> +
> +	newbuf = sla_buffer_map(newsla);
> +	if (!newbuf) {
> +		sla_free(newsla, newlen, true);
> +		return -EFAULT;
> +	}
> +
> +	memcpy(newbuf, oldbuf, oldlen);
> +
> +	sla_buffer_unmap(newsla, newbuf);
> +	sla_free(oldsla, oldlen, true);
> +	*sla = newsla;
> +	*len = newlen;
> +
> +	return 0;
> +}
> +
> +static int sev_tio_do_cmd(int cmd, void *data, size_t data_len, int *psp_ret,
> +			  struct tsm_dsm_tio *dev_data, struct tsm_spdm *spdm)
> +{
> +	int rc;
> +
> +	*psp_ret = 0;
> +	rc = sev_do_cmd(cmd, data, psp_ret);
> +
> +	if (WARN_ON(!spdm && !rc && *psp_ret == SEV_RET_SPDM_REQUEST))
> +		return -EIO;
> +
> +	if (rc == 0 && *psp_ret == SEV_RET_EXPAND_BUFFER_LENGTH_REQUEST) {
> +		int rc1, rc2;
> +
> +		rc1 = sla_expand(&dev_data->output, &dev_data->output_len);
> +		if (rc1 < 0)
> +			return rc1;
> +
> +		rc2 = sla_expand(&dev_data->scratch, &dev_data->scratch_len);
> +		if (rc2 < 0)
> +			return rc2;
> +
> +		if (!rc1 && !rc2)
> +			/* Neither buffer requires expansion, this is wrong */

Is this check correct?  I think you return 1 on no need to expand.

> +			return -EFAULT;
> +
> +		*psp_ret = 0;
> +		rc = sev_do_cmd(cmd, data, psp_ret);
> +	}
> +
> +	if (spdm && (rc == 0 || rc == -EIO) && *psp_ret == SEV_RET_SPDM_REQUEST) {
> +		struct spdm_dobj_hdr_resp *resp_hdr;
> +		struct spdm_dobj_hdr_req *req_hdr;
> +		struct sev_tio_status *tio_status = to_tio_status(dev_data);
> +		size_t resp_len = tio_status->spdm_req_size_max -
> +			(sla_dobj_id_to_size(SPDM_DOBJ_ID_RESP) + sizeof(struct sla_buffer_hdr));
> +
> +		if (!dev_data->cmd) {
> +			if (WARN_ON_ONCE(!data_len || (data_len != *(u32 *) data)))
> +				return -EINVAL;
> +			if (WARN_ON(data_len > sizeof(dev_data->cmd_data)))
> +				return -EFAULT;
> +			memcpy(dev_data->cmd_data, data, data_len);
> +			memset(&dev_data->cmd_data[data_len], 0xFF,
> +			       sizeof(dev_data->cmd_data) - data_len);
> +			dev_data->cmd = cmd;
> +		}
> +
> +		req_hdr = sla_to_dobj_req_hdr(dev_data->reqbuf);
> +		resp_hdr = sla_to_dobj_resp_hdr(dev_data->respbuf);
> +		switch (req_hdr->data_type) {
> +		case DOBJ_DATA_TYPE_SPDM:
> +			rc = TSM_PROTO_CMA_SPDM;
> +			break;
> +		case DOBJ_DATA_TYPE_SECURE_SPDM:
> +			rc = TSM_PROTO_SECURED_CMA_SPDM;
> +			break;
> +		default:
> +			rc = -EINVAL;
> +			return rc;

			return -EINVAL;

> +		}
> +		resp_hdr->data_type = req_hdr->data_type;
> +		spdm->req_len = req_hdr->hdr.length - sla_dobj_id_to_size(SPDM_DOBJ_ID_REQ);
> +		spdm->rsp_len = resp_len;
> +	} else if (dev_data && dev_data->cmd) {
> +		/* For either error or success just stop the bouncing */
> +		memset(dev_data->cmd_data, 0, sizeof(dev_data->cmd_data));
> +		dev_data->cmd = 0;
> +	}
> +
> +	return rc;
> +}
> +

> +static int spdm_ctrl_init(struct tsm_spdm *spdm, struct spdm_ctrl *ctrl,
> +			  struct tsm_dsm_tio *dev_data)

This seems like a slightly odd function as it is initializing two different
things.  To me I'd read this as only initializing the spdm_ctrl structure.
Perhaps split, or rename?

> +{
> +	ctrl->req = dev_data->req;
> +	ctrl->resp = dev_data->resp;
> +	ctrl->scratch = dev_data->scratch;
> +	ctrl->output = dev_data->output;
> +
> +	spdm->req = sla_to_data(dev_data->reqbuf, SPDM_DOBJ_ID_REQ);
> +	spdm->rsp = sla_to_data(dev_data->respbuf, SPDM_DOBJ_ID_RESP);
> +	if (!spdm->req || !spdm->rsp)
> +		return -EFAULT;
> +
> +	return 0;
> +}

> +
> +int sev_tio_init_locked(void *tio_status_page)
> +{
> +	struct sev_tio_status *tio_status = tio_status_page;
> +	struct sev_data_tio_status data_status = {
> +		.length = sizeof(data_status),
> +	};
> +	int ret = 0, psp_ret = 0;

ret always set before use so don't initialize.

> +
> +	data_status.status_paddr = __psp_pa(tio_status_page);
> +	ret = __sev_do_cmd_locked(SEV_CMD_TIO_STATUS, &data_status, &psp_ret);
> +	if (ret)
> +		return ret;
> +
> +	if (tio_status->length < offsetofend(struct sev_tio_status, tdictx_size) ||
> +	    tio_status->flags & 0xFFFFFF00)
> +		return -EFAULT;
> +
> +	if (!tio_status->tio_en && !tio_status->tio_init_done)
> +		return -ENOENT;
> +
> +	if (tio_status->tio_init_done)
> +		return -EBUSY;
> +
> +	struct sev_data_tio_init ti = { .length = sizeof(ti) };
> +
> +	ret = __sev_do_cmd_locked(SEV_CMD_TIO_INIT, &ti, &psp_ret);
> +	if (ret)
> +		return ret;
> +
> +	ret = __sev_do_cmd_locked(SEV_CMD_TIO_STATUS, &data_status, &psp_ret);
> +	if (ret)
> +		return ret;
> +
> +	return 0;
	return __sev_do_cmd_locked() perhaps.

> +}
> +
> +int sev_tio_dev_create(struct tsm_dsm_tio *dev_data, u16 device_id,
> +		       u16 root_port_id, u8 segment_id)
> +{
> +	struct sev_tio_status *tio_status = to_tio_status(dev_data);
> +	struct sev_data_tio_dev_create create = {
> +		.length = sizeof(create),
> +		.device_id = device_id,
> +		.root_port_id = root_port_id,
> +		.segment_id = segment_id,
> +	};
> +	void *data_pg;
> +	int ret;
> +
> +	dev_data->dev_ctx = sla_alloc(tio_status->devctx_size, true);
> +	if (IS_SLA_NULL(dev_data->dev_ctx))
> +		return -ENOMEM;
> +
> +	data_pg = snp_alloc_firmware_page(GFP_KERNEL_ACCOUNT);
> +	if (!data_pg) {
> +		ret = -ENOMEM;
> +		goto free_ctx_exit;
> +	}
> +
> +	create.dev_ctx_sla = dev_data->dev_ctx;
> +	ret = sev_tio_do_cmd(SEV_CMD_TIO_DEV_CREATE, &create, sizeof(create),
> +			     &dev_data->psp_ret, dev_data, NULL);
> +	if (ret)
> +		goto free_data_pg_exit;
> +
> +	dev_data->data_pg = data_pg;
> +
> +	return ret;

return 0;  Might as well make it clear this is always a good path.

> +
> +free_data_pg_exit:
> +	snp_free_firmware_page(data_pg);
> +free_ctx_exit:
> +	sla_free(create.dev_ctx_sla, tio_status->devctx_size, true);
> +	return ret;
> +}

> +
> +int sev_tio_dev_connect(struct tsm_dsm_tio *dev_data, u8 tc_mask, u8 ids[8], u8 cert_slot,
> +			struct tsm_spdm *spdm)
> +{
> +	struct sev_data_tio_dev_connect connect = {
> +		.length = sizeof(connect),
> +		.tc_mask = tc_mask,
> +		.cert_slot = cert_slot,
> +		.dev_ctx_sla = dev_data->dev_ctx,
> +		.ide_stream_id = {
> +			ids[0], ids[1], ids[2], ids[3],
> +			ids[4], ids[5], ids[6], ids[7]
> +		},
> +	};
> +	int ret;
> +
> +	if (WARN_ON(IS_SLA_NULL(dev_data->dev_ctx)))
> +		return -EFAULT;
> +	if (!(tc_mask & 1))
> +		return -EINVAL;
> +
> +	ret = spdm_ctrl_alloc(dev_data, spdm);
> +	if (ret)
> +		return ret;
> +	ret = spdm_ctrl_init(spdm, &connect.spdm_ctrl, dev_data);
> +	if (ret)
> +		return ret;
> +
> +	ret = sev_tio_do_cmd(SEV_CMD_TIO_DEV_CONNECT, &connect, sizeof(connect),
> +			     &dev_data->psp_ret, dev_data, spdm);
> +
> +	return ret;

return sev_tio_do_cmd...

> +}
> +
> +int sev_tio_dev_disconnect(struct tsm_dsm_tio *dev_data, struct tsm_spdm *spdm, bool force)
> +{
> +	struct sev_data_tio_dev_disconnect dc = {
> +		.length = sizeof(dc),
> +		.dev_ctx_sla = dev_data->dev_ctx,
> +		.force = force,
> +	};
> +	int ret;
> +
> +	if (WARN_ON_ONCE(IS_SLA_NULL(dev_data->dev_ctx)))
> +		return -EFAULT;
> +
> +	ret = sspdm_ctrl_initpdm_ctrl_init(spdm, &dc.spdm_ctrl, dev_data);
> +	if (ret)
> +		return ret;
> +
> +	ret = sev_tio_do_cmd(SEV_CMD_TIO_DEV_DISCONNECT, &dc, sizeof(dc),
> +			     &dev_data->psp_ret, dev_data, spdm);
> +
> +	return ret;

return sev_tio..

> +}
> +
> +int sev_tio_asid_fence_clear(struct sla_addr_t dev_ctx, u64 gctx_paddr, int *psp_ret)
> +{
> +	struct sev_data_tio_asid_fence_clear c = {
> +		.length = sizeof(c),
> +		.dev_ctx_paddr = dev_ctx,
> +		.gctx_paddr = gctx_paddr,
> +	};
> +
> +	return sev_do_cmd(SEV_CMD_TIO_ASID_FENCE_CLEAR, &c, psp_ret);
> +}
> +
> +int sev_tio_asid_fence_status(struct tsm_dsm_tio *dev_data, u16 device_id, u8 segment_id,
> +			      u32 asid, bool *fenced)
The meaning of return codes in these functions is a mix of errno and SEV specific.
Perhaps some documentation to make that clear, or even a typedef for the SEV ones?
> +{
> +	u64 *status = prep_data_pg(u64, dev_data);
> +	struct sev_data_tio_asid_fence_status s = {
> +		.length = sizeof(s),
> +		.dev_ctx_paddr = dev_data->dev_ctx,
> +		.asid = asid,
> +		.status_pa = __psp_pa(status),
> +	};
> +	int ret;
> +
> +	ret = sev_do_cmd(SEV_CMD_TIO_ASID_FENCE_STATUS, &s, &dev_data->psp_ret);
> +
> +	if (ret == SEV_RET_SUCCESS) {

I guess this gets more complex in future series to mean that checking
the opposite isn't the way to go?
	if (ret != SEV_RET_SUCCESS)
		return ret;

If not I'd do that to reduce indent and have a nice quick exit
for errors.

> +		u8 dma_status = *status & 0x3;
> +		u8 mmio_status = (*status >> 2) & 0x3;
> +
> +		switch (dma_status) {
> +		case 0:
These feel like magic numbers that could perhaps have defines to give
them pretty names?
> +			*fenced = false;
> +			break;
> +		case 1:
> +		case 3:
> +			*fenced = true;
> +			break;
> +		default:
> +			pr_err("%04x:%x:%x.%d: undefined DMA fence state %#llx\n",
> +			       segment_id, PCI_BUS_NUM(device_id),
> +			       PCI_SLOT(device_id), PCI_FUNC(device_id), *status);
> +			*fenced = true;
> +			break;
> +		}
> +
> +		switch (mmio_status) {
> +		case 0:
Same as above, names might be nice.
> +			*fenced = false;
> +			break;
> +		case 3:
> +			*fenced = true;
> +			break;
> +		default:
> +			pr_err("%04x:%x:%x.%d: undefined MMIO fence state %#llx\n",
> +			       segment_id, PCI_BUS_NUM(device_id),
> +			       PCI_SLOT(device_id), PCI_FUNC(device_id), *status);
> +			*fenced = true;
> +			break;
> +		}
> +	}
> +
> +	return ret;
> +}

> diff --git a/drivers/crypto/ccp/sev-dev-tsm.c b/drivers/crypto/ccp/sev-dev-tsm.c
> new file mode 100644
> index 000000000000..4702139185a2
> --- /dev/null
> +++ b/drivers/crypto/ccp/sev-dev-tsm.c

> +
> +static uint nr_ide_streams = TIO_DEFAULT_NR_IDE_STREAMS;
> +module_param_named(ide_nr, nr_ide_streams, uint, 0644);
> +MODULE_PARM_DESC(ide_nr, "Set the maximum number of IDE streams per PHB");
> +
> +#define dev_to_sp(dev)		((struct sp_device *)dev_get_drvdata(dev))
> +#define dev_to_psp(dev)		((struct psp_device *)(dev_to_sp(dev)->psp_data))
> +#define dev_to_sev(dev)		((struct sev_device *)(dev_to_psp(dev)->sev_data))
> +#define tsm_dev_to_sev(tsmdev)	dev_to_sev((tsmdev)->dev.parent)
> +#define tsm_pf0_to_sev(t)	tsm_dev_to_sev((t)->base.owner)
> +
> +/*to_pci_tsm_pf0((pdev)->tsm)*/

Left over of something?

> +#define pdev_to_tsm_pf0(pdev)	(((pdev)->tsm && (pdev)->tsm->dsm_dev) ? \
> +				((struct pci_tsm_pf0 *)((pdev)->tsm->dsm_dev->tsm)) : \
> +				NULL)
> +
> +#define tsm_pf0_to_data(t)	(&(container_of((t), struct tio_dsm, tsm)->data))
> +
> +static int sev_tio_spdm_cmd(struct pci_tsm_pf0 *dsm, int ret)
> +{
> +	struct tsm_dsm_tio *dev_data = tsm_pf0_to_data(dsm);
> +	struct tsm_spdm *spdm = &dsm->spdm;
> +	struct pci_doe_mb *doe_mb;
> +
> +	/* Check the main command handler response before entering the loop */
> +	if (ret == 0 && dev_data->psp_ret != SEV_RET_SUCCESS)
> +		return -EINVAL;
> +	else if (ret <= 0)
> +		return ret;

	if (ret <= 0)
		return ret;

as returned already in the if path.

> +
> +	/* ret > 0 means "SPDM requested" */
> +	while (ret > 0) {
> +		/* The proto can change at any point */
> +		if (ret == TSM_PROTO_CMA_SPDM) {
> +			doe_mb = dsm->doe_mb;
> +		} else if (ret == TSM_PROTO_SECURED_CMA_SPDM) {
> +			doe_mb = dsm->doe_mb_sec;
> +		} else {
> +			ret = -EFAULT;
> +			break;
I'd be tempted to do
		else 
			return -EFAULT;
here and similar if the other error path below.
> +		}
> +
> +		ret = pci_doe(doe_mb, PCI_VENDOR_ID_PCI_SIG, ret,
> +			      spdm->req, spdm->req_len, spdm->rsp, spdm->rsp_len);
> +		if (ret < 0)
> +			break;
> +
> +		WARN_ON_ONCE(ret == 0); /* The response should never be empty */
> +		spdm->rsp_len = ret;
> +		ret = sev_tio_continue(dev_data, &dsm->spdm);
> +	}
> +
> +	return ret;
> +}
> +
> +static int stream_enable(struct pci_ide *ide)
> +{
> +	struct pci_dev *rp = pcie_find_root_port(ide->pdev);
> +	int ret;
> +
> +	ret = pci_ide_stream_enable(rp, ide);

I would suggest using a goto for the cleanup to avoid having
an unusual code flow, but more interesting to me is why pci_ide_stream_enable()
has side effects on failure that means we have to call pci_ide_stream_disable().

Looking at Dan's patch I can see that we might have programmed things
but then the hardware failed to set them up.   Perhaps we should push
cleanup into that function or at least add something to docs to point
out that we must cleanup whether or not that function succeeds?

> +	if (!ret)
> +		ret = pci_ide_stream_enable(ide->pdev, ide);
> +
> +	if (ret)
> +		pci_ide_stream_disable(rp, ide);
> +
> +	return ret;
> +}
> +
> +static int streams_enable(struct pci_ide **ide)
> +{
> +	int ret = 0;
> +
> +	for (int i = 0; i < TIO_IDE_MAX_TC; ++i) {
> +		if (ide[i]) {
> +			ret = stream_enable(ide[i]);
> +			if (ret)
Personal taste thing so up to you but I'd do return ret;
here and return 0 at the end. 
> +				break;
> +		}
> +	}
> +
> +	return ret;
> +}

> +static u8 streams_setup(struct pci_ide **ide, u8 *ids)
> +{
> +	bool def = false;
> +	u8 tc_mask = 0;
> +	int i;
> +
> +	for (i = 0; i < TIO_IDE_MAX_TC; ++i) {
> +		if (!ide[i]) {
> +			ids[i] = 0xFF;
> +			continue;
> +		}
> +
> +		tc_mask |= 1 << i;

Kind of obvious either way but perhaps a slight preference for
		tc_mask |= BIT(i);

> +		ids[i] = ide[i]->stream_id;
> +
> +		if (!def) {
> +			struct pci_ide_partner *settings;
> +
> +			settings = pci_ide_to_settings(ide[i]->pdev, ide[i]);
> +			settings->default_stream = 1;
> +			def = true;
> +		}
> +
> +		stream_setup(ide[i]);
> +	}
> +
> +	return tc_mask;
> +}
> +
> +static int streams_register(struct pci_ide **ide)
> +{
> +	int ret = 0, i;
> +
> +	for (i = 0; i < TIO_IDE_MAX_TC; ++i) {
> +		if (!ide[i])
> +			continue;
Worth doing if the line is long or there is more to do here.  Maybe there
is in some follow up series, but fo rnow
		if (ide[i]) {
			ret = pci_ide_stream_register(ide[i]);
			if (ret)
				return ret;
		}
Seems cleaner to me.

> +
> +		ret = pci_ide_stream_register(ide[i]);
> +		if (ret)
> +			break;
> +	}
> +
> +	return ret;
> +}

> +static void stream_teardown(struct pci_ide *ide)
> +{
> +	pci_ide_stream_teardown(ide->pdev, ide);
> +	pci_ide_stream_teardown(pcie_find_root_port(ide->pdev), ide);
> +}
> +
> +static void streams_teardown(struct pci_ide **ide)

Seems unbalanced to have stream_alloc take
the struct tsm_dsm_tio * pointer to just access dev_data->ide
but the teardown passes that directly.

I'm be happier if they were both passed the same thing (either struct pci_ide **ide
or struct tsm_dsm_tio *dev_data).
Slight preference for struct pci_ide **ide in stream_alloc as well.

> +{
> +	for (int i = 0; i < TIO_IDE_MAX_TC; ++i) {
> +		if (ide[i]) {
> +			stream_teardown(ide[i]);
> +			pci_ide_stream_free(ide[i]);
> +			ide[i] = NULL;
> +		}
> +	}
> +}
> +
> +static int stream_alloc(struct pci_dev *pdev, struct tsm_dsm_tio *dev_data,
> +			unsigned int tc)
> +{
> +	struct pci_dev *rp = pcie_find_root_port(pdev);
> +	struct pci_ide *ide;
> +
> +	if (dev_data->ide[tc]) {
> +		pci_err(pdev, "Stream for class=%d already registered", tc);
> +		return -EBUSY;
> +	}
> +
> +	/* FIXME: find a better way */
> +	if (nr_ide_streams != TIO_DEFAULT_NR_IDE_STREAMS)
> +		pci_notice(pdev, "Enable non-default %d streams", nr_ide_streams);
> +	pci_ide_set_nr_streams(to_pci_host_bridge(rp->bus->bridge), nr_ide_streams);
> +
> +	ide = pci_ide_stream_alloc(pdev);
> +	if (!ide)
> +		return -EFAULT;
> +
> +	/* Blindly assign streamid=0 to TC=0, and so on */
> +	ide->stream_id = tc;
> +
> +	dev_data->ide[tc] = ide;
> +
> +	return 0;
> +}


> +
> +static int dsm_create(struct pci_tsm_pf0 *dsm)
> +{
> +	struct pci_dev *pdev = dsm->base_tsm.pdev;
> +	u8 segment_id = pdev->bus ? pci_domain_nr(pdev->bus) : 0;
> +	struct pci_dev *rootport = pcie_find_root_port(pdev);
> +	u16 device_id = pci_dev_id(pdev);
> +	struct tsm_dsm_tio *dev_data = tsm_pf0_to_data(dsm);
> +	struct page *req_page;
> +	u16 root_port_id;
> +	u32 lnkcap = 0;
> +	int ret;
> +
> +	if (pci_read_config_dword(rootport, pci_pcie_cap(rootport) + PCI_EXP_LNKCAP,
> +				  &lnkcap))
> +		return -ENODEV;
> +
> +	root_port_id = FIELD_GET(PCI_EXP_LNKCAP_PN, lnkcap);
> +
> +	req_page = alloc_page(GFP_KERNEL_ACCOUNT | __GFP_ZERO);

Allocate then leak a page?  req_page isn't used.

> +	if (!req_page)
> +		return -ENOMEM;
> +
> +	ret = sev_tio_dev_create(dev_data, device_id, root_port_id, segment_id);
> +	if (ret)
> +		goto free_resp_exit;
> +
> +	return 0;
> +
> +free_resp_exit:
> +	__free_page(req_page);
> +	return ret;
> +}
> +
> +static int dsm_connect(struct pci_dev *pdev)
> +{
> +	struct pci_tsm_pf0 *dsm = pdev_to_tsm_pf0(pdev);
> +	struct tsm_dsm_tio *dev_data = tsm_pf0_to_data(dsm);
> +	u8 ids[TIO_IDE_MAX_TC];
> +	u8 tc_mask;
> +	int ret;
> +
> +	ret = stream_alloc(pdev, dev_data, 0);

As above. I'd use dev_data->ide instead of dev_data as the parameter here
to match the other cases later.  I'm guessing this parameter choice
was something that underwent evolution and perhaps ended up less
than ideal.

> +	if (ret)
> +		return ret;
> +
> +	ret = dsm_create(dsm);
> +	if (ret)
> +		goto ide_free_exit;
> +
> +	tc_mask = streams_setup(dev_data->ide, ids);
> +
> +	ret = sev_tio_dev_connect(dev_data, tc_mask, ids, dsm->cert_slot, &dsm->spdm);
> +	ret = sev_tio_spdm_cmd(dsm, ret);
> +	if (ret)
> +		goto free_exit;
> +
> +	streams_enable(dev_data->ide);
> +
> +	ret = streams_register(dev_data->ide);
> +	if (ret)
> +		goto free_exit;
> +
> +	return 0;
> +
> +free_exit:
> +	sev_tio_dev_reclaim(dev_data, &dsm->spdm);
> +
> +	streams_disable(dev_data->ide);
> +ide_free_exit:
> +
> +	streams_teardown(dev_data->ide);
> +
> +	if (ret > 0)
> +		ret = -EFAULT;

My gut feeling would be that this manipulation of positive
return codes should be pushed to where it is more obvious why it is happening.
Either inside the functions or int the if (ret) blocks above.
It's sufficiently unusual I'd like it to be more obvious.

> +	return ret;
> +}
> +
> +static void dsm_disconnect(struct pci_dev *pdev)
> +{
> +	bool force = SYSTEM_HALT <= system_state && system_state <= SYSTEM_RESTART;
> +	struct pci_tsm_pf0 *dsm = pdev_to_tsm_pf0(pdev);
> +	struct tsm_dsm_tio *dev_data = tsm_pf0_to_data(dsm);
> +	int ret;
> +
> +	ret = sev_tio_dev_disconnect(dev_data, &dsm->spdm, force);
> +	ret = sev_tio_spdm_cmd(dsm, ret);
> +	if (ret && !force) {
> +		ret = sev_tio_dev_disconnect(dev_data, &dsm->spdm, true);
> +		sev_tio_spdm_cmd(dsm, ret);
> +	}
> +
> +	sev_tio_dev_reclaim(dev_data, &dsm->spdm);
> +
> +	streams_disable(dev_data->ide);
> +	streams_unregister(dev_data->ide);
> +	streams_teardown(dev_data->ide);
> +}
> +
> +static struct pci_tsm_ops sev_tsm_ops = {
> +	.probe = dsm_probe,
> +	.remove = dsm_remove,
> +	.connect = dsm_connect,
> +	.disconnect = dsm_disconnect,
> +};
> +
> +void sev_tsm_init_locked(struct sev_device *sev, void *tio_status_page)
> +{
> +	struct sev_tio_status *t __free(kfree) = kzalloc(sizeof(*t), GFP_KERNEL);
Whilst it is fine here, general advice is don't mix gotos and cleanup.h magic
in a given function (see the comments in the header).  

> +	struct tsm_dev *tsmdev;
> +	int ret;
> +
> +	WARN_ON(sev->tio_status);
> +
> +	if (!t)
> +		return;
> +
> +	ret = sev_tio_init_locked(tio_status_page);
> +	if (ret) {
> +		pr_warn("SEV-TIO STATUS failed with %d\n", ret);
> +		goto error_exit;
> +	}
> +
> +	tsmdev = tsm_register(sev->dev, &sev_tsm_ops);
> +	if (IS_ERR(tsmdev))
> +		goto error_exit;
> +
> +	memcpy(t, tio_status_page, sizeof(*t));

If it weren't for the goto then this could be

	struct sev_tio_status *t __free(kfree) =
		kmemdup(tio_status_page, sizeof(*t), GFP_KERNEL;
	if (!t)
		return;


> +
> +	pr_notice("SEV-TIO status: EN=%d INIT_DONE=%d rq=%d..%d rs=%d..%d "
> +		  "scr=%d..%d out=%d..%d dev=%d tdi=%d algos=%x\n",
> +		  t->tio_en, t->tio_init_done,
> +		  t->spdm_req_size_min, t->spdm_req_size_max,
> +		  t->spdm_rsp_size_min, t->spdm_rsp_size_max,
> +		  t->spdm_scratch_size_min, t->spdm_scratch_size_max,
> +		  t->spdm_out_size_min, t->spdm_out_size_max,
> +		  t->devctx_size, t->tdictx_size,
> +		  t->tio_crypto_alg);
> +
> +	sev->tsmdev = tsmdev;
> +	sev->tio_status = no_free_ptr(t);
> +
> +	return;
> +
> +error_exit:
> +	pr_err("Failed to enable SEV-TIO: ret=%d en=%d initdone=%d SEV=%d\n",
> +	       ret, t->tio_en, t->tio_init_done,
> +	       boot_cpu_has(X86_FEATURE_SEV));
> +	pr_err("Check BIOS for: SMEE, SEV Control, SEV-ES ASID Space Limit=99,\n"
> +	       "SNP Memory (RMP Table) Coverage, RMP Coverage for 64Bit MMIO Ranges\n"
> +	       "SEV-SNP Support, SEV-TIO Support, PCIE IDE Capability\n");

Superficially feels to me that some of this set of helpful messages is only relevant
to some error paths - maybe just print the most relevant parts where those problems
are detected?

> +}
> +
> +void sev_tsm_uninit(struct sev_device *sev)
> +{
> +	if (sev->tsmdev)
> +		tsm_unregister(sev->tsmdev);
> +
> +	sev->tsmdev = NULL;
> +}



