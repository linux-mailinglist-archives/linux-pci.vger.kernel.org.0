Return-Path: <linux-pci+bounces-17244-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 70A1F9D6CFE
	for <lists+linux-pci@lfdr.de>; Sun, 24 Nov 2024 08:57:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B6251B21249
	for <lists+linux-pci@lfdr.de>; Sun, 24 Nov 2024 07:57:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B33015EFA1;
	Sun, 24 Nov 2024 07:57:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="SGWzEk+b"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F28B333FE
	for <linux-pci@vger.kernel.org>; Sun, 24 Nov 2024 07:56:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732435020; cv=none; b=EO+S7hKXa7YZwT7+1y0kR2vC+LDmDJMcTR6A6UkEFiASXuZgLo6GXR23+Id0lKog7Y6e8nRQbdbja046SyEAmK8k1ZIaroretEEgssPej5A7bfCMZGm6Mask97Q/KxJ5v4xFRF4sXbqLbm9XSOprC9JDQvTxUscFQee3fapkhUc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732435020; c=relaxed/simple;
	bh=eTeZngZ2CD5x1VnoS5j2Uu4bnpfWtu1c786Oy+M0bv8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qKdtlYzUSO+vUsGEHotPkiNs58QmRLunBWv4Y/r7NxBfyvbsI0R60uqMgrt5xZ4vhvOwvXkx362HEC6hzW6Nm5Y8dTAI2/sJFJOzVvMSV/wTJ5jCdWz3MNREQpoRkzk9jREW9lLZObDQ5Pvc6gLEeQ9LUSyebqBf+bBnP4Flo74=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=SGWzEk+b; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-2ea39f39666so2744439a91.2
        for <linux-pci@vger.kernel.org>; Sat, 23 Nov 2024 23:56:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1732435017; x=1733039817; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=MvzMMatJaJC6fn1CTIppDcQxDX5G8ymaqPcIiF4+OJg=;
        b=SGWzEk+bkkzkmg+Oa7m+CQ9KFKTGnUQHntqEGW0VXHphqiUVJPtyqbJokeif670Zcb
         zDKJv55F/Nf8Q9I7V9qtslzMCFzU6IQFVwet0nd7POcoEiMoY2dF1VeLb9BoKDJXVwy8
         ABq7WbXTbB0mot99+dxAska1Do5lye2sESJrhKzw7ruboI4uErtiEGskWMyDrM5+yU0n
         e/dh1Nl1x9lTg/CX5G0bCyhDIcTyBuCMR+ppSCjs3+8vo3YChY+j/I4DNyyGI4paMZhT
         a5Nwwht+hgCv3cy+ftVW0mYSE5kIulQyt6wHhL0/y/CbDpyi6jxM+cea7XtN2BhHassf
         2oCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732435017; x=1733039817;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=MvzMMatJaJC6fn1CTIppDcQxDX5G8ymaqPcIiF4+OJg=;
        b=OkTQu+IAY6XKEOtgafx85EV/ogW5baag5N55ui1bktqjP1XBD9/s8lwH2Tdw321ALe
         9bGVmvD5lMi/YpLfmnj0qVyVtoywPoZQSrIzVbNLsA+jz5ne2yAochiOJhQF9tYBDR0a
         P79gx9+panF5BcwW66ovSrQirdHiNX+YJX+CldyPj1PA0a5Yt2T/BMrH2MbwtXWHvAp7
         FnuasHeR/251AEgI8sVR10XzpHhaVFAsIgc+lrjO79LKTl0mMLLv4JFjjI7hno69mYv9
         PyEx4mBzEH6pEi2giD5L85gHf/vpj6cNisYMWyXsICIbbG8jirQq7dzMMSfR6Lon33ss
         O0dA==
X-Forwarded-Encrypted: i=1; AJvYcCUpeEaJcc84hWq23+2+qEI4wTgKmdwieQ88ZTDq/zOdc4GiDlHVXmIRWJRJsI7BEc7EmCtk8N0JDBw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzBjzJj9aUGmZIzvq/JbQ07nrhyAguoBEACmV5VAZU36MptcaCR
	cLgtU45bAOFyOsqDL5q59V55Bug3MEnfcE1DEVet8VUZjZU6r/4J2cLPOa0pOghdd30d6WyvBlo
	=
X-Gm-Gg: ASbGncskI/ZITPqwJBJtbwEEhZV912eLqnCmUZw57/x+J+ng1Emx7CtjsGfEpnPg8FW
	HjKufO3OJo9v3r8QqB71i0qQe9amGShhweKRhrFLXcLw/T6lRh9h26fpaWdfbdSI3g1ev5+w1Ps
	6tOOMfy9NGDE7QsO+bIuc+VJrWWwxU7pFsnwTEsFfRTvKCpYusLsoDqWGqA1NO/DXTtIqEun6ps
	ZzkA5QFwV8XvNAFiCrfi99WzrxrYNCoW3efFdCMErderYA/10OWxjkY1GrrZfKcSg==
X-Google-Smtp-Source: AGHT+IGdWfdtasOFZlgyNBLQXP7SrxwI7ofYJPPx+Sse9/1p2f63g0ypoiZEY/0rZSPRE8c9Eie0NA==
X-Received: by 2002:a17:90a:c10e:b0:2ea:2a8d:dd2a with SMTP id 98e67ed59e1d1-2eb0e86761cmr10531239a91.27.1732435017215;
        Sat, 23 Nov 2024 23:56:57 -0800 (PST)
Received: from thinkpad ([2409:40f2:100d:708e:8ced:6048:5b4d:7203])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2eaca70a911sm5840127a91.1.2024.11.23.23.56.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 23 Nov 2024 23:56:56 -0800 (PST)
Date: Sun, 24 Nov 2024 13:26:45 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Frank Li <Frank.Li@nxp.com>
Cc: Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>, Arnd Bergmann <arnd@arndb.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
	imx@lists.linux.dev, Niklas Cassel <cassel@kernel.org>,
	dlemoal@kernel.org, maz@kernel.org, tglx@linutronix.de,
	jdmason@kudzu.us
Subject: Re: [PATCH v8 4/6] PCI: endpoint: pci-epf-test: Add doorbell test
 support
Message-ID: <20241124075645.szue5nzm4gcjspxf@thinkpad>
References: <20241116-ep-msi-v8-0-6f1f68ffd1bb@nxp.com>
 <20241116-ep-msi-v8-4-6f1f68ffd1bb@nxp.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20241116-ep-msi-v8-4-6f1f68ffd1bb@nxp.com>

On Sat, Nov 16, 2024 at 09:40:44AM -0500, Frank Li wrote:
> Add three registers: doorbell_bar, doorbell_addr, and doorbell_data,
> along with doorbell_done. Use pci_epf_alloc_doorbell() to allocate a

I don't see 'doorbell_done' defined anywhere.

> doorbell address space.
> 
> Enable the Root Complex (RC) side driver to trigger pci-epc-test's doorbell
> callback handler by writing doorbell_data to the mapped doorbell_bar's
> address space.
> 
> Set doorbell_done in the doorbell callback to indicate completion.
> 

Same here.

> To avoid broken compatibility, add new command COMMAND_ENABLE_DOORBELL

'avoid breaking compatibility between host and endpoint,...'

> and COMMAND_DISABLE_DOORBELL. Host side need send COMMAND_ENABLE_DOORBELL
> to map one bar's inbound address to MSI space. the command
> COMMAND_DISABLE_DOORBELL to recovery original inbound address mapping.
> 
> 	 	Host side new driver	Host side old driver
> 
> EP: new driver      S				F
> EP: old driver      F				F

So the last case of old EP and host drivers will fail?

> 
> S: If EP side support MSI, 'pcitest -B' return success.
>    If EP side doesn't support MSI, the same to 'F'.
> 
> F: 'pcitest -B' return failure, other case as usual.
> 
> Tested-by: Niklas Cassel <cassel@kernel.org>
> Signed-off-by: Frank Li <Frank.Li@nxp.com>
> ---
> Change from v7 to v8
> - rename to pci_epf_align_inbound_addr_lo_hi()
> 
> Change from v6 to v7
> - use help function pci_epf_align_addr_lo_hi()
> 
> Change from v5 to v6
> - rename doorbell_addr to doorbell_offset
> 
> Chagne from v4 to v5
> - Add doorbell free at unbind function.
> - Move msi irq handler to here to more complex user case, such as differece
> doorbell can use difference handler function.
> - Add Niklas's code to handle fixed bar's case. If need add your signed-off
> tag or co-developer tag, please let me know.
> 
> change from v3 to v4
> - remove revid requirement
> - Add command COMMAND_ENABLE_DOORBELL and COMMAND_DISABLE_DOORBELL.
> - call pci_epc_set_bar() to map inbound address to MSI space only at
> COMMAND_ENABLE_DOORBELL.
> ---
>  drivers/pci/endpoint/functions/pci-epf-test.c | 117 ++++++++++++++++++++++++++
>  1 file changed, 117 insertions(+)
> 
> diff --git a/drivers/pci/endpoint/functions/pci-epf-test.c b/drivers/pci/endpoint/functions/pci-epf-test.c
> index ef6677f34116e..410b2f4bb7ce7 100644
> --- a/drivers/pci/endpoint/functions/pci-epf-test.c
> +++ b/drivers/pci/endpoint/functions/pci-epf-test.c
> @@ -11,12 +11,14 @@
>  #include <linux/dmaengine.h>
>  #include <linux/io.h>
>  #include <linux/module.h>
> +#include <linux/msi.h>
>  #include <linux/slab.h>
>  #include <linux/pci_ids.h>
>  #include <linux/random.h>
>  
>  #include <linux/pci-epc.h>
>  #include <linux/pci-epf.h>
> +#include <linux/pci-ep-msi.h>
>  #include <linux/pci_regs.h>
>  
>  #define IRQ_TYPE_INTX			0
> @@ -29,6 +31,8 @@
>  #define COMMAND_READ			BIT(3)
>  #define COMMAND_WRITE			BIT(4)
>  #define COMMAND_COPY			BIT(5)
> +#define COMMAND_ENABLE_DOORBELL		BIT(6)
> +#define COMMAND_DISABLE_DOORBELL	BIT(7)
>  
>  #define STATUS_READ_SUCCESS		BIT(0)
>  #define STATUS_READ_FAIL		BIT(1)
> @@ -39,6 +43,11 @@
>  #define STATUS_IRQ_RAISED		BIT(6)
>  #define STATUS_SRC_ADDR_INVALID		BIT(7)
>  #define STATUS_DST_ADDR_INVALID		BIT(8)
> +#define STATUS_DOORBELL_SUCCESS		BIT(9)
> +#define STATUS_DOORBELL_ENABLE_SUCCESS	BIT(10)
> +#define STATUS_DOORBELL_ENABLE_FAIL	BIT(11)
> +#define STATUS_DOORBELL_DISABLE_SUCCESS BIT(12)
> +#define STATUS_DOORBELL_DISABLE_FAIL	BIT(13)
>  
>  #define FLAG_USE_DMA			BIT(0)
>  
> @@ -74,6 +83,9 @@ struct pci_epf_test_reg {
>  	u32	irq_type;
>  	u32	irq_number;
>  	u32	flags;
> +	u32	doorbell_bar;
> +	u32	doorbell_offset;
> +	u32	doorbell_data;
>  } __packed;
>  
>  static struct pci_epf_header test_header = {
> @@ -642,6 +654,63 @@ static void pci_epf_test_raise_irq(struct pci_epf_test *epf_test,
>  	}
>  }
>  
> +static void pci_epf_enable_doorbell(struct pci_epf_test *epf_test, struct pci_epf_test_reg *reg)
> +{
> +	enum pci_barno bar = reg->doorbell_bar;
> +	struct pci_epf *epf = epf_test->epf;
> +	struct pci_epc *epc = epf->epc;
> +	struct pci_epf_bar db_bar;

db_bar = {};

> +	struct msi_msg *msg;
> +	size_t offset;
> +	int ret;
> +
> +	if (bar < BAR_0 || bar == epf_test->test_reg_bar || !epf->db_msg) {

What is the need of BAR check here and below? pci_epf_alloc_doorbell() should've
allocated proper BAR already.

> +		reg->status |= STATUS_DOORBELL_ENABLE_FAIL;
> +		return;
> +	}
> +
> +	msg = &epf->db_msg[0].msg;
> +	ret = pci_epf_align_inbound_addr_lo_hi(epf, bar, msg->address_lo, msg->address_hi,
> +					       &db_bar.phys_addr, &offset);
> +
> +	if (ret) {
> +		reg->status |= STATUS_DOORBELL_ENABLE_FAIL;
> +		return;
> +	}
> +
> +	reg->doorbell_offset = offset;
> +
> +	db_bar.barno = bar;
> +	db_bar.size = epf->bar[bar].size;
> +	db_bar.flags = epf->bar[bar].flags;
> +	db_bar.addr = NULL;

Not needed if you initialize above.

> +
> +	ret = pci_epc_set_bar(epc, epf->func_no, epf->vfunc_no, &db_bar);
> +	if (!ret)
> +		reg->status |= STATUS_DOORBELL_ENABLE_SUCCESS;
> +	else
> +		reg->status |= STATUS_DOORBELL_ENABLE_FAIL;
> +}
> +

[...]

>  static const struct pci_epc_event_ops pci_epf_test_event_ops = {
>  	.epc_init = pci_epf_test_epc_init,
>  	.epc_deinit = pci_epf_test_epc_deinit,
> @@ -921,12 +1010,34 @@ static int pci_epf_test_bind(struct pci_epf *epf)
>  	if (ret)
>  		return ret;
>  
> +	ret = pci_epf_alloc_doorbell(epf, 1);
> +	if (!ret) {
> +		struct pci_epf_test_reg *reg = epf_test->reg[test_reg_bar];
> +		struct msi_msg *msg = &epf->db_msg[0].msg;
> +		enum pci_barno bar;
> +
> +		bar = pci_epc_get_next_free_bar(epc_features, test_reg_bar + 1);

NO_BAR check?

- Mani

-- 
மணிவண்ணன் சதாசிவம்

