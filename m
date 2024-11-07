Return-Path: <linux-pci+bounces-16295-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 98D6E9C11F6
	for <lists+linux-pci@lfdr.de>; Thu,  7 Nov 2024 23:48:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B99761C22417
	for <lists+linux-pci@lfdr.de>; Thu,  7 Nov 2024 22:48:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C38F216A38;
	Thu,  7 Nov 2024 22:48:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PhWwPt59"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D5B01DC04A;
	Thu,  7 Nov 2024 22:48:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731019690; cv=none; b=FzoGl/LG7IOc2IzAes4SqzC8k1vUs42HV/RULghS/9uTOIKGRmGgm93q7j/gKUmqxCrZ2vL0TB9cyH9/auTHYhUZ04we3L1e4iipFsQRP/H5WPyESsz857xMurCZ9eLjh1ScELHkh3TOpr+wYE/umB4lJ3thcbgyI5HYUJ5zFg4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731019690; c=relaxed/simple;
	bh=1jEWFPslJhyTsHY7jlPrzIrlFV5iRC0ktcnDIL79478=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VbRrsTg4EbG7oljSbflqyK/OYQO+o+vb15drUr1votpjkQ1AAKRmXPY2HUoTvoz6EY45nQvHg9neOXV8M/l3jJxeeVGsNiFgr1HlqqE9d9iAMBhad+sVkc/8XCAqwN88HKAn10I9jW27FYcDztwu1B3Co0SdZikhASWfFnU2Ng4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PhWwPt59; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 03D56C4CECC;
	Thu,  7 Nov 2024 22:48:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731019689;
	bh=1jEWFPslJhyTsHY7jlPrzIrlFV5iRC0ktcnDIL79478=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=PhWwPt59s3FIaaR2rNwH9mkcXjr5BILavrpypfFB7tDv6YxN4agd7ipAlFMIpZXS/
	 tW7+u1PVa/HGBFIi2UJvH1GKHFvwryg6dNXVE7fdM+7IO+GbmoY8JeDKt3/6xQ+fCa
	 dYm2k3SOy7mkqP1ULpM2560DRNkyFzCPvtZHHcpOKrNlDLGtoZtHYPTO2BfyV1A6Y1
	 +H80GVrOOHffgZ83L/JqCiQlQEHVjPUxDssDy0bnGP84jsyUveaCMgcXthHmYyrUun
	 MX1J1rlVhRf2/UtMsX4nXRYfcSONc+4QvPNmPh0fV6D8QW2wLoEqZIFGvknU4ftmlm
	 zWNr3vD71FEKw==
Date: Thu, 7 Nov 2024 23:48:04 +0100
From: Niklas Cassel <cassel@kernel.org>
To: Frank Li <Frank.li@nxp.com>
Cc: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>, Arnd Bergmann <arnd@arndb.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
	imx@lists.linux.dev, dlemoal@kernel.org, maz@kernel.org,
	tglx@linutronix.de, jdmason@kudzu.us
Subject: Re: [PATCH v4 3/5] PCI: endpoint: pci-epf-test: Add doorbell test
 support
Message-ID: <Zy1DpKQxY7BkoxPP@ryzen>
References: <20241031-ep-msi-v4-0-717da2d99b28@nxp.com>
 <20241031-ep-msi-v4-3-717da2d99b28@nxp.com>
 <Zy02mPTvaPAFFxGi@ryzen>
 <Zy1CxtKSgRuEPX5A@lizhi-Precision-Tower-5810>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zy1CxtKSgRuEPX5A@lizhi-Precision-Tower-5810>

On Thu, Nov 07, 2024 at 05:44:22PM -0500, Frank Li wrote:
> On Thu, Nov 07, 2024 at 10:52:24PM +0100, Niklas Cassel wrote:
> > On Thu, Oct 31, 2024 at 12:27:02PM -0400, Frank Li wrote:
> > > Add three registers: doorbell_bar, doorbell_addr, and doorbell_data,
> > > along with doorbell_done. Use pci_epf_alloc_doorbell() to allocate a
> > > doorbell address space.
> > >
> > > Enable the Root Complex (RC) side driver to trigger pci-epc-test's doorbell
> > > callback handler by writing doorbell_data to the mapped doorbell_bar's
> > > address space.
> > >
> > > Set doorbell_done in the doorbell callback to indicate completion.
> > >
> > > To avoid broken compatibility, add new command COMMAND_ENABLE_DOORBELL
> > > and COMMAND_DISABLE_DOORBELL. Host side need send COMMAND_ENABLE_DOORBELL
> > > to map one bar's inbound address to MSI space. the command
> > > COMMAND_DISABLE_DOORBELL to recovery original inbound address mapping.
> > >
> > > 	 	Host side new driver	Host side old driver
> > >
> > > EP: new driver      S				F
> > > EP: old driver      F				F
> > >
> > > S: If EP side support MSI, 'pcitest -B' return success.
> > >    If EP side doesn't support MSI, the same to 'F'.
> > >
> > > F: 'pcitest -B' return failure, other case as usual.
> > >
> > > Signed-off-by: Frank Li <Frank.Li@nxp.com>
> > > ---
> > > change from v3 to v4
> > > - remove revid requirement
> > > - Add command COMMAND_ENABLE_DOORBELL and COMMAND_DISABLE_DOORBELL.
> > > - call pci_epc_set_bar() to map inbound address to MSI space only at
> > > COMMAND_ENABLE_DOORBELL.
> > > ---
> > >  drivers/pci/endpoint/functions/pci-epf-test.c | 104 ++++++++++++++++++++++++++
> > >  1 file changed, 104 insertions(+)
> > >
> > > diff --git a/drivers/pci/endpoint/functions/pci-epf-test.c b/drivers/pci/endpoint/functions/pci-epf-test.c
> > > index 7c2ed6eae53ad..dcb69921497fd 100644
> > > --- a/drivers/pci/endpoint/functions/pci-epf-test.c
> > > +++ b/drivers/pci/endpoint/functions/pci-epf-test.c
> > > @@ -11,12 +11,14 @@
> > >  #include <linux/dmaengine.h>
> > >  #include <linux/io.h>
> > >  #include <linux/module.h>
> > > +#include <linux/msi.h>
> > >  #include <linux/slab.h>
> > >  #include <linux/pci_ids.h>
> > >  #include <linux/random.h>
> > >
> > >  #include <linux/pci-epc.h>
> > >  #include <linux/pci-epf.h>
> > > +#include <linux/pci-ep-msi.h>
> > >  #include <linux/pci_regs.h>
> > >
> > >  #define IRQ_TYPE_INTX			0
> > > @@ -29,6 +31,8 @@
> > >  #define COMMAND_READ			BIT(3)
> > >  #define COMMAND_WRITE			BIT(4)
> > >  #define COMMAND_COPY			BIT(5)
> > > +#define COMMAND_ENABLE_DOORBELL		BIT(6)
> > > +#define COMMAND_DISABLE_DOORBELL	BIT(7)
> > >
> > >  #define STATUS_READ_SUCCESS		BIT(0)
> > >  #define STATUS_READ_FAIL		BIT(1)
> > > @@ -39,6 +43,11 @@
> > >  #define STATUS_IRQ_RAISED		BIT(6)
> > >  #define STATUS_SRC_ADDR_INVALID		BIT(7)
> > >  #define STATUS_DST_ADDR_INVALID		BIT(8)
> > > +#define STATUS_DOORBELL_SUCCESS		BIT(9)
> > > +#define STATUS_DOORBELL_ENABLE_SUCCESS	BIT(10)
> > > +#define STATUS_DOORBELL_ENABLE_FAIL	BIT(11)
> > > +#define STATUS_DOORBELL_DISABLE_SUCCESS BIT(12)
> > > +#define STATUS_DOORBELL_DISABLE_FAIL	BIT(13)
> > >
> > >  #define FLAG_USE_DMA			BIT(0)
> > >
> > > @@ -74,6 +83,9 @@ struct pci_epf_test_reg {
> > >  	u32	irq_type;
> > >  	u32	irq_number;
> > >  	u32	flags;
> > > +	u32	doorbell_bar;
> > > +	u32	doorbell_addr;
> > > +	u32	doorbell_data;
> > >  } __packed;
> > >
> > >  static struct pci_epf_header test_header = {
> > > @@ -630,6 +642,60 @@ static void pci_epf_test_raise_irq(struct pci_epf_test *epf_test,
> > >  	}
> > >  }
> > >
> > > +static void pci_epf_enable_doorbell(struct pci_epf_test *epf_test, struct pci_epf_test_reg *reg)
> > > +{
> > > +	enum pci_barno bar = reg->doorbell_bar;
> > > +	struct pci_epf *epf = epf_test->epf;
> > > +	struct pci_epc *epc = epf->epc;
> > > +	struct pci_epf_bar db_bar;
> > > +	struct msi_msg *msg;
> > > +	u64 doorbell_addr;
> > > +	u32 align;
> > > +	int ret;
> > > +
> > > +	align = epf_test->epc_features->align;
> > > +	align = align ? align : 128;
> > > +
> > > +	if (bar < BAR_0 || bar == epf_test->test_reg_bar || !epf->db_msg) {
> > > +		reg->status |= STATUS_DOORBELL_ENABLE_FAIL;
> > > +		return;
> > > +	}
> > > +
> > > +	msg = &epf->db_msg[0].msg;
> > > +	doorbell_addr = msg->address_hi;
> > > +	doorbell_addr <<= 32;
> > > +	doorbell_addr |= msg->address_lo;
> > > +
> > > +	db_bar.phys_addr = round_down(doorbell_addr, align);
> > > +	db_bar.barno = bar;
> > > +	db_bar.size = epf->bar[bar].size;
> > > +	db_bar.flags = epf->bar[bar].flags;
> > > +	db_bar.addr = NULL;
> > > +
> > > +	ret = pci_epc_set_bar(epc, epf->func_no, epf->vfunc_no, &db_bar);
> > > +	if (!ret)
> > > +		reg->status |= STATUS_DOORBELL_ENABLE_SUCCESS;
> > > +}
> > > +
> > > +static void pci_epf_disable_doorbell(struct pci_epf_test *epf_test, struct pci_epf_test_reg *reg)
> > > +{
> > > +	enum pci_barno bar = reg->doorbell_bar;
> > > +	struct pci_epf *epf = epf_test->epf;
> > > +	struct pci_epc *epc = epf->epc;
> > > +	int ret;
> > > +
> > > +	if (bar < BAR_0 || bar == epf_test->test_reg_bar || !epf->db_msg) {
> > > +		reg->status |= STATUS_DOORBELL_DISABLE_FAIL;
> > > +		return;
> > > +	}
> > > +
> > > +	ret = pci_epc_set_bar(epc, epf->func_no, epf->vfunc_no, &epf->bar[bar]);
> > > +	if (ret)
> > > +		reg->status |= STATUS_DOORBELL_DISABLE_FAIL;
> > > +	else
> > > +		reg->status |= STATUS_DOORBELL_DISABLE_SUCCESS;
> > > +}
> > > +
> > >  static void pci_epf_test_cmd_handler(struct work_struct *work)
> > >  {
> > >  	u32 command;
> > > @@ -676,6 +742,14 @@ static void pci_epf_test_cmd_handler(struct work_struct *work)
> > >  		pci_epf_test_copy(epf_test, reg);
> > >  		pci_epf_test_raise_irq(epf_test, reg);
> > >  		break;
> > > +	case COMMAND_ENABLE_DOORBELL:
> > > +		pci_epf_enable_doorbell(epf_test, reg);
> > > +		pci_epf_test_raise_irq(epf_test, reg);
> > > +		break;
> > > +	case COMMAND_DISABLE_DOORBELL:
> > > +		pci_epf_disable_doorbell(epf_test, reg);
> > > +		pci_epf_test_raise_irq(epf_test, reg);
> > > +		break;
> > >  	default:
> > >  		dev_err(dev, "Invalid command 0x%x\n", command);
> > >  		break;
> > > @@ -810,11 +884,24 @@ static int pci_epf_test_link_down(struct pci_epf *epf)
> > >  	return 0;
> > >  }
> > >
> > > +static int pci_epf_test_doorbell(struct pci_epf *epf, int index)
> > > +{
> > > +	struct pci_epf_test *epf_test = epf_get_drvdata(epf);
> > > +	enum pci_barno test_reg_bar = epf_test->test_reg_bar;
> > > +	struct pci_epf_test_reg *reg = epf_test->reg[test_reg_bar];
> > > +
> > > +	reg->status |= STATUS_DOORBELL_SUCCESS;
> > > +	pci_epf_test_raise_irq(epf_test, reg);
> > > +
> > > +	return 0;
> > > +}
> > > +
> > >  static const struct pci_epc_event_ops pci_epf_test_event_ops = {
> > >  	.epc_init = pci_epf_test_epc_init,
> > >  	.epc_deinit = pci_epf_test_epc_deinit,
> > >  	.link_up = pci_epf_test_link_up,
> > >  	.link_down = pci_epf_test_link_down,
> > > +	.doorbell = pci_epf_test_doorbell,
> > >  };
> > >
> > >  static int pci_epf_test_alloc_space(struct pci_epf *epf)
> > > @@ -909,6 +996,23 @@ static int pci_epf_test_bind(struct pci_epf *epf)
> > >  	if (ret)
> > >  		return ret;
> > >
> > > +	ret = pci_epf_alloc_doorbell(epf, 1);
> >
> > Calling pci_epf_alloc_doorbell() unconditionally from bind will lead to the
> > following print for all platforms that have not configured a msi-parent:
> > [   64.543388] a40000000.pcie-ep: Failed to allocate MSI
> >
> > In ealier discussions, I thought that you wanted to call
> > pci_epf_alloc_doorbell() in pci_epf_enable_doorbell(), and then let
> > pci_epf_enable_doorbell() return STATUS_DOORBELL_ENABLE_FAIL
> > if pci_epf_enable_doorbell() failed.
> >
> >
> > Perhaps you could modify pci_epf_enable_doorbell() to also check if
> > dev->msi.domain is NULL, before calling pci_epc_alloc_doorbell(),
> > and if dev->msi.domain is NULL, perhaps print a clearer error,
> > e.g. "no msi domain found, is 'msi-parent' device tree property missing?"
> > Or put the text in a comment next to the error check, if you think that a
> > print seems too silly.
> 
> I think resource should be allocated in bind. it may be too frequent to
> allocate and free msi resources when call pci_epf_enable_doorbell()/
> pci_epf_disable_doorbell().
> 
> If you think "a40000000.pcie-ep: Failed to allocate MSI" a noise, I think
> we can add a msi_domain check in pci_epc_alloc_doorbell() and print a nice
> message at pci_epc_alloc_doorbell().
> 
> It should be similar as eDMA detect. It'd better show captiblity
> information at beginning instead of defer to when use it.

Sounds good to me.


Kind regards,
Niklas

