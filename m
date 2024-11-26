Return-Path: <linux-pci+bounces-17340-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6ECD29D9759
	for <lists+linux-pci@lfdr.de>; Tue, 26 Nov 2024 13:41:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D5A98B20F8B
	for <lists+linux-pci@lfdr.de>; Tue, 26 Nov 2024 12:41:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03ED11CBE8C;
	Tue, 26 Nov 2024 12:41:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="M3uBYfLu"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 360961BD012
	for <linux-pci@vger.kernel.org>; Tue, 26 Nov 2024 12:41:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732624880; cv=none; b=VNWtVztrCcEEhonyK3F6RQjItVrKNuj0aXNT7CR0W4U1DsmylRnhBS4L+8+0GUebeC8Q5oHUQ7lgDraiPqAEJnxJWeOJGg2n7ma7LvpyKOwZq9Ky2AdAWL9emg7ovPmARrWQpWoSmrxgnPavm9PoxWgP8HGh57VLR4qt7S+VA7U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732624880; c=relaxed/simple;
	bh=5QGqLgj7ult2KpL1mhiCaa8OlPSUKLYv0B9W4FZ6P0Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rHh2ZDu5zUWBAI7mKHDbSrMhQodgdL/Mn+LwX1KxrlKRD8CSTxp2y8vsLd66QtoYPVgjcuH6Ld+gv3u/PKhZ6kgh7o1TJLCac0sbN1WCMVZNgvrhazkdIY7ZG3rWAj9n2C+5Q5IAHPukrd3QGTJ4UZGDd5nVkcaDBS7UH/t+F88=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=M3uBYfLu; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-21207f0d949so52948305ad.2
        for <linux-pci@vger.kernel.org>; Tue, 26 Nov 2024 04:41:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1732624878; x=1733229678; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=MxF+aV1Hv4QY3oDIZgKkkm4GIfDo73DrZkwY5UF6N5I=;
        b=M3uBYfLu5WKiE83Ye0ENonv/Oe0GfDOt0hX6RMT4rFAfDCnAlKvpq1TQQigv+nf1rb
         DbdjIA41TQeU/i3Vs/FVdXhK0oj8bkv+A+LAICvlIAhxzEruvD6p7X0jwUt8M5CNEt3a
         k3BhnoVUzwwgS8hOzAq2c8TDcepK9uE0EO7RuMLjeuwgcgRHFDN7P37Wo2bhfi7c87Fv
         kq4uXAjgFoiEQhUudNAALRXag/bfo3yir0l1jCQZgk0Mjf3HOC9Vr62SW0ZWNvAio5TJ
         2X9QxNnE9PHxiBW8iw456c0W3TApeWDqi+Nh0yWgLRBfZyTMs4oFPUf9g20uT8pq1aIF
         tVDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732624878; x=1733229678;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=MxF+aV1Hv4QY3oDIZgKkkm4GIfDo73DrZkwY5UF6N5I=;
        b=JulZO80WIY6iM+O/8QaDGnNRDmtdoqrb0FaYmoKCl6Eoc4htt6d+R8SuoYPyDSOrxI
         DxsmO9VhNhdgC4HHGYpww2rQIoCwwP9FenXUelB5phbtHhGxuzq6CRUWEGdK3R6QPmFN
         OVOFyI+XavomepQhuwSx9KRbnobGfetVRw76ccc1/xjmiA90L11b0E8Y/74nbmk+RtuS
         rV4C8pvJO7EJeK3lc1iutSgueigODJ9rRNo4Cuoh7qkkjvdhp1S9VPyuT48hG+Jbcuyz
         xWoIaJSE5fa3n1d8H47o5159arrcG/sSPbCgY2zt3aNDBSLxYeCdHPVb1oWPbZJoAFOT
         rkJw==
X-Forwarded-Encrypted: i=1; AJvYcCUVsBdcUXBYNrrk5jqQn5+2ukNrlej+JCVWowjjp8Ibz9um3V1GNbiJaWPJFOmISpwA1oBJjd22W0A=@vger.kernel.org
X-Gm-Message-State: AOJu0YwpKe+KlV5WLuS4XFFKoJudVbD/0i+d6CnwKqgzZMjmm9MF0klj
	412IgwZTH+/Cq6pMuLMgQwwXMMgdAqeiAKwlDFpOAcGrTUBbHxWBUGvBDDl75A==
X-Gm-Gg: ASbGncvN/RRnS8zAp3rc2IOHC7/iEpSHTqZ6qMf6CovbLDqyqzwnw+IYsNgMgpgOAJr
	LNMn1O2az/sn2x5s/sz6bgU+LfhCybeAw9Psn03Ivv+NNEpourFkPZA9oIPdN7fYrZiprYZ8jJe
	ta231KvL0JSSmL4nv11V/iN/ej7zXjBXPwfvuohbq3RaN2qnyPQpUfLmQg2hOBEDSutZMFofD4b
	XiZPnzPNeF47AEdQYDzJQIqGr1a4loGU4WZKcxHDkPj8jWX703SJdgenx/q
X-Google-Smtp-Source: AGHT+IHNkV0w1MtKgqBXdudpD0c62ethWhe9CLuXm06H3Scg2apzmGTe2RkEFVHEhLbz5G18I7I10Q==
X-Received: by 2002:a17:902:dac5:b0:212:500:74e with SMTP id d9443c01a7336-2129f51d2c6mr233343125ad.11.1732624878328;
        Tue, 26 Nov 2024 04:41:18 -0800 (PST)
Received: from thinkpad ([120.60.136.64])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2129dc22237sm83758345ad.243.2024.11.26.04.41.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Nov 2024 04:41:17 -0800 (PST)
Date: Tue, 26 Nov 2024 18:11:12 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Niklas Cassel <cassel@kernel.org>
Cc: Frank Li <Frank.li@nxp.com>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>, Arnd Bergmann <arnd@arndb.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
	imx@lists.linux.dev, dlemoal@kernel.org, maz@kernel.org,
	tglx@linutronix.de, jdmason@kudzu.us
Subject: Re: [PATCH v8 4/6] PCI: endpoint: pci-epf-test: Add doorbell test
 support
Message-ID: <20241126124112.5o4c3lzem72lkvdw@thinkpad>
References: <20241116-ep-msi-v8-0-6f1f68ffd1bb@nxp.com>
 <20241116-ep-msi-v8-4-6f1f68ffd1bb@nxp.com>
 <20241124075645.szue5nzm4gcjspxf@thinkpad>
 <Z0TNMIX4ehaB+mSn@lizhi-Precision-Tower-5810>
 <20241126042523.6qlmhkjfl5kwouth@thinkpad>
 <Z0WcKeM2630u_xSK@ryzen>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Z0WcKeM2630u_xSK@ryzen>

On Tue, Nov 26, 2024 at 11:00:09AM +0100, Niklas Cassel wrote:
> On Tue, Nov 26, 2024 at 09:55:23AM +0530, Manivannan Sadhasivam wrote:
> > On Mon, Nov 25, 2024 at 02:17:04PM -0500, Frank Li wrote:
> > > On Sun, Nov 24, 2024 at 01:26:45PM +0530, Manivannan Sadhasivam wrote:
> > > > On Sat, Nov 16, 2024 at 09:40:44AM -0500, Frank Li wrote:
> > > > > Add three registers: doorbell_bar, doorbell_addr, and doorbell_data,
> > > > > along with doorbell_done. Use pci_epf_alloc_doorbell() to allocate a
> > > >
> > > > I don't see 'doorbell_done' defined anywhere.
> > > >
> > > > > doorbell address space.
> > > > >
> > > > > Enable the Root Complex (RC) side driver to trigger pci-epc-test's doorbell
> > > > > callback handler by writing doorbell_data to the mapped doorbell_bar's
> > > > > address space.
> > > > >
> > > > > Set doorbell_done in the doorbell callback to indicate completion.
> > > > >
> > > >
> > > > Same here.
> > > >
> > > > > To avoid broken compatibility, add new command COMMAND_ENABLE_DOORBELL
> > > >
> > > > 'avoid breaking compatibility between host and endpoint,...'
> > > >
> > > > > and COMMAND_DISABLE_DOORBELL. Host side need send COMMAND_ENABLE_DOORBELL
> > > > > to map one bar's inbound address to MSI space. the command
> > > > > COMMAND_DISABLE_DOORBELL to recovery original inbound address mapping.
> > > > >
> > > > > 	 	Host side new driver	Host side old driver
> > > > >
> > > > > EP: new driver      S				F
> > > > > EP: old driver      F				F
> > > >
> > > > So the last case of old EP and host drivers will fail?
> > > 
> > > doorbell test will fail if old EP.
> > > 
> > 
> > How come there would be doorbell test if it is an old host driver?
> 
> I also don't understand this.
> 
> The new commands: DOORBELL_ENABLE / DOORBELL_DISABLE
> can only be sent if there is a new host driver.
> 
> Sending DOORBELL_ENABLE / DOORBELL_DISABLE will obviously
> return "Invalid command" if the EP driver is old.
> 
> If EP driver is new, DOORBELL_ENABLE will only return success if the SoC
> has support for GIC ITS and has configured DTS with msi-parent
> (i.e. if the pci_epf_alloc_doorbell() call was successful).
> 
> 
> > 
> > > >
> > > > >
> > > > > S: If EP side support MSI, 'pcitest -B' return success.
> > > > >    If EP side doesn't support MSI, the same to 'F'.
> > > > >
> > > > > F: 'pcitest -B' return failure, other case as usual.
> > > > >
> > > > > Tested-by: Niklas Cassel <cassel@kernel.org>
> > > > > Signed-off-by: Frank Li <Frank.Li@nxp.com>
> > > > > ---
> > > > > Change from v7 to v8
> > > > > - rename to pci_epf_align_inbound_addr_lo_hi()
> > > > >
> > > > > Change from v6 to v7
> > > > > - use help function pci_epf_align_addr_lo_hi()
> > > > >
> > > > > Change from v5 to v6
> > > > > - rename doorbell_addr to doorbell_offset
> > > > >
> > > > > Chagne from v4 to v5
> > > > > - Add doorbell free at unbind function.
> > > > > - Move msi irq handler to here to more complex user case, such as differece
> > > > > doorbell can use difference handler function.
> > > > > - Add Niklas's code to handle fixed bar's case. If need add your signed-off
> > > > > tag or co-developer tag, please let me know.
> > > > >
> > > > > change from v3 to v4
> > > > > - remove revid requirement
> > > > > - Add command COMMAND_ENABLE_DOORBELL and COMMAND_DISABLE_DOORBELL.
> > > > > - call pci_epc_set_bar() to map inbound address to MSI space only at
> > > > > COMMAND_ENABLE_DOORBELL.
> > > > > ---
> > > > >  drivers/pci/endpoint/functions/pci-epf-test.c | 117 ++++++++++++++++++++++++++
> > > > >  1 file changed, 117 insertions(+)
> > > > >
> > > > > diff --git a/drivers/pci/endpoint/functions/pci-epf-test.c b/drivers/pci/endpoint/functions/pci-epf-test.c
> > > > > index ef6677f34116e..410b2f4bb7ce7 100644
> > > > > --- a/drivers/pci/endpoint/functions/pci-epf-test.c
> > > > > +++ b/drivers/pci/endpoint/functions/pci-epf-test.c
> > > > > @@ -11,12 +11,14 @@
> > > > >  #include <linux/dmaengine.h>
> > > > >  #include <linux/io.h>
> > > > >  #include <linux/module.h>
> > > > > +#include <linux/msi.h>
> > > > >  #include <linux/slab.h>
> > > > >  #include <linux/pci_ids.h>
> > > > >  #include <linux/random.h>
> > > > >
> > > > >  #include <linux/pci-epc.h>
> > > > >  #include <linux/pci-epf.h>
> > > > > +#include <linux/pci-ep-msi.h>
> > > > >  #include <linux/pci_regs.h>
> > > > >
> > > > >  #define IRQ_TYPE_INTX			0
> > > > > @@ -29,6 +31,8 @@
> > > > >  #define COMMAND_READ			BIT(3)
> > > > >  #define COMMAND_WRITE			BIT(4)
> > > > >  #define COMMAND_COPY			BIT(5)
> > > > > +#define COMMAND_ENABLE_DOORBELL		BIT(6)
> > > > > +#define COMMAND_DISABLE_DOORBELL	BIT(7)
> > > > >
> > > > >  #define STATUS_READ_SUCCESS		BIT(0)
> > > > >  #define STATUS_READ_FAIL		BIT(1)
> > > > > @@ -39,6 +43,11 @@
> > > > >  #define STATUS_IRQ_RAISED		BIT(6)
> > > > >  #define STATUS_SRC_ADDR_INVALID		BIT(7)
> > > > >  #define STATUS_DST_ADDR_INVALID		BIT(8)
> > > > > +#define STATUS_DOORBELL_SUCCESS		BIT(9)
> > > > > +#define STATUS_DOORBELL_ENABLE_SUCCESS	BIT(10)
> > > > > +#define STATUS_DOORBELL_ENABLE_FAIL	BIT(11)
> > > > > +#define STATUS_DOORBELL_DISABLE_SUCCESS BIT(12)
> > > > > +#define STATUS_DOORBELL_DISABLE_FAIL	BIT(13)
> > > > >
> > > > >  #define FLAG_USE_DMA			BIT(0)
> > > > >
> > > > > @@ -74,6 +83,9 @@ struct pci_epf_test_reg {
> > > > >  	u32	irq_type;
> > > > >  	u32	irq_number;
> > > > >  	u32	flags;
> > > > > +	u32	doorbell_bar;
> > > > > +	u32	doorbell_offset;
> > > > > +	u32	doorbell_data;
> > > > >  } __packed;
> > > > >
> > > > >  static struct pci_epf_header test_header = {
> > > > > @@ -642,6 +654,63 @@ static void pci_epf_test_raise_irq(struct pci_epf_test *epf_test,
> > > > >  	}
> > > > >  }
> > > > >
> > > > > +static void pci_epf_enable_doorbell(struct pci_epf_test *epf_test, struct pci_epf_test_reg *reg)
> > > > > +{
> > > > > +	enum pci_barno bar = reg->doorbell_bar;
> > > > > +	struct pci_epf *epf = epf_test->epf;
> > > > > +	struct pci_epc *epc = epf->epc;
> > > > > +	struct pci_epf_bar db_bar;
> > > >
> > > > db_bar = {};
> > > >
> > > > > +	struct msi_msg *msg;
> > > > > +	size_t offset;
> > > > > +	int ret;
> > > > > +
> > > > > +	if (bar < BAR_0 || bar == epf_test->test_reg_bar || !epf->db_msg) {
> > > >
> > > > What is the need of BAR check here and below? pci_epf_alloc_doorbell() should've
> > > > allocated proper BAR already.
> > > 
> > > Not check it at call pci_epf_alloc_doorbell() because it optional feature.
> > 
> > What is 'optional feature' here? allocating doorbell?
> > 
> > > It return failure when it actually use it.
> > > 
> > 
> > So host can call pci_epf_enable_doorbell() without pci_epf_alloc_doorbell()?
> 
> This patch calls pci_epf_alloc_doorbell() in pci_epf_test_bind(), so at
> .bind() time.
> 
> DOORBELL_ENABLE and DOORBELL_DISABLE are two new commands, so the host driver
> could theoretically send these even if pci_epf_alloc_doorbell() failed.
> 
> 
> pci_epf_test_cmd_handler() additions looks like this:
> 
> +	case COMMAND_ENABLE_DOORBELL:
> +		pci_epf_enable_doorbell(epf_test, reg);
> +		pci_epf_test_raise_irq(epf_test, reg);
> +		break;
> +	case COMMAND_DISABLE_DOORBELL:
> +		pci_epf_disable_doorbell(epf_test, reg);
> +		pci_epf_test_raise_irq(epf_test, reg);
> +		break;
> 
> so they will call pci_epf_enable_doorbell()/pci_epf_disable_doorbell()
> unconditionally, without any check to see if the doorbell was allocated.
> 
> We could move the was doorbell allocated check (if (!epf->db_msg)) to
> pci_epf_test_cmd_handler(), but that would make pci_epf_test_cmd_handler()
> more messy, so personally I think it is fine to keep the doorbell allocated
> check in pci_epf_enable_doorbell()/pci_epf_disable_doorbell().
> 
> 
> I did earlier suggest to Frank to move the pci_epf_alloc_doorbell() call
> to pci_epf_enable_doorbell():
> https://lore.kernel.org/linux-pci/Zy02mPTvaPAFFxGi@ryzen/
> 
> His reply is here::
> https://lore.kernel.org/linux-pci/Zy1CxtKSgRuEPX5A@lizhi-Precision-Tower-5810/
> 
> "it may be too frequent to allocate and free msi resources when call
> pci_epf_enable_doorbell()/pci_epf_disable_doorbell()."
> 
> I don't think that is a good argument, as presumably (in the normal case) an
> EPF driver will enable doorbell in the beginning, and then keep it enabled.
> 
> However, one point could be that pci-epf-test currently does all allocations
> (the allocations for the backing memory) in .bind(), so in one way it makes
> sense to also allocate the doorbell in .bind().
> 
> To play devil's advocate, I guess you could argue that doorbell feature is
> optional, while allocating backing memory for BARs is not, so it makes sense
> that they are not allocated at the same time.
> 

I like the idea of calling pci_epf_alloc_doorbell() in
pci_epf_{enable/disable}_doorbell() APIs. And as you said, it doesn't make sense
to call these APIs too frequently.

- Mani

-- 
மணிவண்ணன் சதாசிவம்

