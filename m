Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A8F1C73FE02
	for <lists+linux-pci@lfdr.de>; Tue, 27 Jun 2023 16:37:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231502AbjF0OhB (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 27 Jun 2023 10:37:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231496AbjF0OhA (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 27 Jun 2023 10:37:00 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36901359D;
        Tue, 27 Jun 2023 07:36:38 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A5BE0611BC;
        Tue, 27 Jun 2023 14:36:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1649BC433C8;
        Tue, 27 Jun 2023 14:36:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1687876597;
        bh=Aa67Wy9ttMGQmXrreabIOo5dIAtA9DW58DMmzxgDC7c=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Hly1BbE3CwP1kJGoLaZ6jljJPt2pb1eYpChb81JLTluzMHguYxD8j3huO9VjPtbdK
         OPuj3u5t9Xk+58DFJMX37XYA6fwbYO6LnSOdhyhi1y+rwhR6uetPrJfIig21sP0A77
         OvHOzvnzcMMyMHY8r3HyXh2xzL/L0eCAcGE43BKMrqO/C2WNjXLSJCluAoJ6/RDGL2
         zdrDAmckpsnTnfI0GgEY5OhlxvUC8vrBJQv6UWbgnaArgcD1UIrMhe83G7JFySSpGy
         4rjLZ+0jzTjX7fQJwTK83StuovkirIltIWs+GzLzLdaFzKWXAA2RPjJLKfXBgdEES9
         wH4RyLtpsq3sA==
Date:   Tue, 27 Jun 2023 20:06:23 +0530
From:   Manivannan Sadhasivam <mani@kernel.org>
To:     Krishna Chaitanya Chundru <quic_krichai@quicinc.com>
Cc:     manivannan.sadhasivam@linaro.org, quic_vbadigan@quicinc.com,
        quic_ramkri@quicinc.com, linux-arm-msm@vger.kernel.org,
        konrad.dybcio@linaro.org,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        "open list:PCI ENDPOINT SUBSYSTEM" <linux-pci@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH RFC v1 1/3] PCI: endpoint: Add wakeup host API to EPC core
Message-ID: <20230627143623.GF5490@thinkpad>
References: <1686754850-29817-1-git-send-email-quic_krichai@quicinc.com>
 <1686754850-29817-2-git-send-email-quic_krichai@quicinc.com>
 <20230623054313.GB5611@thinkpad>
 <3291d4f1-1cb8-ad7e-3dd4-5b9cab9e22c7@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <3291d4f1-1cb8-ad7e-3dd4-5b9cab9e22c7@quicinc.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Jun 26, 2023 at 07:10:53PM +0530, Krishna Chaitanya Chundru wrote:
> 
> On 6/23/2023 11:13 AM, Manivannan Sadhasivam wrote:
> > On Wed, Jun 14, 2023 at 08:30:47PM +0530, Krishna chaitanya chundru wrote:
> > > Endpoint cannot send any data/MSI when the device state is in
> > > D3cold or D3hot. Endpoint needs to bring the device back to D0
> > > to send any kind of data.
> > > 
> > > For this endpoint can send inband PME the device is in D3hot or
> > > toggle wake when the device is D3 cold.
> > > 
> > Are you referring to "host" as the "device"? If so, then it is a wrong
> > terminology.
> I will correct this in next series.
> > 
> > > To support this adding wake up host to epc core.
> > > 
> > Commit message should be imperative.
> > 
> > > Signed-off-by: Krishna chaitanya chundru <quic_krichai@quicinc.com>
> > > ---
> > >   drivers/pci/endpoint/pci-epc-core.c | 29 +++++++++++++++++++++++++++++
> > >   include/linux/pci-epc.h             |  3 +++
> > >   2 files changed, 32 insertions(+)
> > > 
> > > diff --git a/drivers/pci/endpoint/pci-epc-core.c b/drivers/pci/endpoint/pci-epc-core.c
> > > index 46c9a5c..d203947 100644
> > > --- a/drivers/pci/endpoint/pci-epc-core.c
> > > +++ b/drivers/pci/endpoint/pci-epc-core.c
> > > @@ -167,6 +167,35 @@ const struct pci_epc_features *pci_epc_get_features(struct pci_epc *epc,
> > >   EXPORT_SYMBOL_GPL(pci_epc_get_features);
> > >   /**
> > > + * pci_epc_wakeup_host() - interrupt the host system
> > s/interrupt the host system/Wakeup the host
> > 
> > > + * @epc: the EPC device which has to interrupt the host
> > s/interrupt/wake
> > 
> > > + * @func_no: the physical endpoint function number in the EPC device
> > > + * @vfunc_no: the virtual endpoint function number in the physical function
> > > + *
> > > + * Invoke to wakeup host
> > > + */
> > > +int pci_epc_wakeup_host(struct pci_epc *epc, u8 func_no, u8 vfunc_no)
> > > +{
> > > +	int ret;
> > > +
> > > +	if (IS_ERR_OR_NULL(epc) || func_no >= epc->max_functions)
> > > +		return -EINVAL;
> > > +
> > > +	if (vfunc_no > 0 && (!epc->max_vfs || vfunc_no > epc->max_vfs[func_no]))
> > > +		return -EINVAL;
> > > +
> > Use proper errno for both of the above.
> > 
> > - Mani
> 
> raise_irq functions also using errno can you please suggest correct value.
> 

Let's keep it as it is, we can change all later.

- Mani

> - KC
> 
> > > +	if (!epc->ops->wakeup_host)
> > > +		return 0;
> > > +
> > > +	mutex_lock(&epc->lock);
> > > +	ret = epc->ops->wakeup_host(epc, func_no, vfunc_no);
> > > +	mutex_unlock(&epc->lock);
> > > +
> > > +	return ret;
> > > +}
> > > +EXPORT_SYMBOL_GPL(pci_epc_wakeup_host);
> > > +
> > > +/**
> > >    * pci_epc_stop() - stop the PCI link
> > >    * @epc: the link of the EPC device that has to be stopped
> > >    *
> > > diff --git a/include/linux/pci-epc.h b/include/linux/pci-epc.h
> > > index 301bb0e..a8496be 100644
> > > --- a/include/linux/pci-epc.h
> > > +++ b/include/linux/pci-epc.h
> > > @@ -59,6 +59,7 @@ pci_epc_interface_string(enum pci_epc_interface_type type)
> > >    * @start: ops to start the PCI link
> > >    * @stop: ops to stop the PCI link
> > >    * @get_features: ops to get the features supported by the EPC
> > > + * @wakeup_host: ops to wakeup the host
> > >    * @owner: the module owner containing the ops
> > >    */
> > >   struct pci_epc_ops {
> > > @@ -88,6 +89,7 @@ struct pci_epc_ops {
> > >   	void	(*stop)(struct pci_epc *epc);
> > >   	const struct pci_epc_features* (*get_features)(struct pci_epc *epc,
> > >   						       u8 func_no, u8 vfunc_no);
> > > +	int	(*wakeup_host)(struct pci_epc *epc, u8 func_no, u8 vfunc_no);
> > >   	struct module *owner;
> > >   };
> > > @@ -232,6 +234,7 @@ int pci_epc_start(struct pci_epc *epc);
> > >   void pci_epc_stop(struct pci_epc *epc);
> > >   const struct pci_epc_features *pci_epc_get_features(struct pci_epc *epc,
> > >   						    u8 func_no, u8 vfunc_no);
> > > +int pci_epc_wakeup_host(struct pci_epc *epc, u8 func_no, u8 vfunc_no);
> > >   enum pci_barno
> > >   pci_epc_get_first_free_bar(const struct pci_epc_features *epc_features);
> > >   enum pci_barno pci_epc_get_next_free_bar(const struct pci_epc_features
> > > -- 
> > > 2.7.4
> > > 

-- 
மணிவண்ணன் சதாசிவம்
