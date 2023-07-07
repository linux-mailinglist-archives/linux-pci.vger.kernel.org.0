Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D267774AAFC
	for <lists+linux-pci@lfdr.de>; Fri,  7 Jul 2023 08:15:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231965AbjGGGPS (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 7 Jul 2023 02:15:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229815AbjGGGPS (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 7 Jul 2023 02:15:18 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 197821737;
        Thu,  6 Jul 2023 23:15:17 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 91046617A5;
        Fri,  7 Jul 2023 06:15:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 64CE5C433C8;
        Fri,  7 Jul 2023 06:15:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1688710515;
        bh=+NYJwRTCIMCwGZqWkNR5vlaX4WVi8M1aIhhOzKf+GrA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ml3C4cM16FwO8xbx2/tRgIJ3WCKgXE4JNoMdahF9k7Sx8vuhpe+FamtNqovHVI8hu
         IkCMDziNbCyBCwTd3AeqP5vW6rM7jKSw/FGwklzDhrq7zgPqCtCGLVXF/5uxOYuOPo
         fEux/ieiVDmsFogF3hIakR+5Md6idVR2xr+4r2/jel7ECUsMkHCn9n8z+Kz4E2r5cm
         1wRWNmmVjfiJXLVBbDM+qlgoqCR4Z8Px6XbzL0zXyuiFGHV73P0amiaGNj/TX0l6uO
         uWLElim35itePVkuKtevD6YBMUQYor4GwCnSHethahh7Y0pWOl3qxBWZwt2GavXL6t
         uM/TZbY2cJ5/g==
Date:   Fri, 7 Jul 2023 11:44:48 +0530
From:   Manivannan Sadhasivam <mani@kernel.org>
To:     Krishna chaitanya chundru <quic_krichai@quicinc.com>
Cc:     manivannan.sadhasivam@linaro.org, helgaas@kernel.org,
        linux-pci@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, quic_vbadigan@quicinc.com,
        quic_nitegupt@quicinc.com, quic_skananth@quicinc.com,
        quic_ramkri@quicinc.com, krzysztof.kozlowski@linaro.org,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Jeffrey Hugo <quic_jhugo@quicinc.com>,
        "open list:MHI BUS" <mhi@lists.linux.dev>
Subject: Re: [PATCH v2 7/8] PCI: epf-mhi: Add wakeup host op
Message-ID: <20230707061448.GF6001@thinkpad>
References: <1688122331-25478-1-git-send-email-quic_krichai@quicinc.com>
 <1688122331-25478-8-git-send-email-quic_krichai@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1688122331-25478-8-git-send-email-quic_krichai@quicinc.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Jun 30, 2023 at 04:22:10PM +0530, Krishna chaitanya chundru wrote:
> Add wakeup host op for MHI EPF.
> If the D-state is in D3cold toggle wake signal, otherwise send PME.
> 
> Signed-off-by: Krishna chaitanya chundru <quic_krichai@quicinc.com>
> ---
>  drivers/pci/endpoint/functions/pci-epf-mhi.c | 19 +++++++++++++++++++
>  include/linux/mhi_ep.h                       |  1 +
>  2 files changed, 20 insertions(+)
> 
> diff --git a/drivers/pci/endpoint/functions/pci-epf-mhi.c b/drivers/pci/endpoint/functions/pci-epf-mhi.c
> index 64ff37d..deb742c 100644
> --- a/drivers/pci/endpoint/functions/pci-epf-mhi.c
> +++ b/drivers/pci/endpoint/functions/pci-epf-mhi.c
> @@ -237,6 +237,24 @@ static int pci_epf_mhi_write_to_host(struct mhi_ep_cntrl *mhi_cntrl,
>  	return 0;
>  }
>  
> +static int pci_epf_mhi_wakeup_host(struct mhi_ep_cntrl *mhi_cntrl)
> +{
> +	struct pci_epf_mhi *epf_mhi = to_epf_mhi(mhi_cntrl);
> +	struct pci_epf *epf = epf_mhi->epf;
> +	struct pci_epc *epc = epf->epc;
> +	int ret;
> +
> +	if (mhi_cntrl->dstate == PCI_D3cold)
> +		ret = pci_epc_wakeup_host(epc, epf->func_no,
> +					epf->vfunc_no, PCI_WAKEUP_TOGGLE_WAKE);
> +	else
> +		ret = pci_epc_wakeup_host(epc, epf->func_no,
> +					epf->vfunc_no, PCI_WAKEUP_SEND_PME);
> +

If the wakeup argument is of type bool (ie. bool use_pme), then

	wakeup = (mhi_cntrl->dstate == PCI_D3cold) ? false : true;

	return pci_epc_wakeup_host(epc, epf->func_no, epf->vfunc_no, state);

- Mani

> +	return ret;
> +
> +}
> +
>  static int pci_epf_mhi_core_init(struct pci_epf *epf)
>  {
>  	struct pci_epf_mhi *epf_mhi = epf_get_drvdata(epf);
> @@ -293,6 +311,7 @@ static int pci_epf_mhi_link_up(struct pci_epf *epf)
>  	mhi_cntrl->unmap_free = pci_epf_mhi_unmap_free;
>  	mhi_cntrl->read_from_host = pci_epf_mhi_read_from_host;
>  	mhi_cntrl->write_to_host = pci_epf_mhi_write_to_host;
> +	mhi_cntrl->wakeup_host = pci_epf_mhi_wakeup_host;
>  
>  	/* Register the MHI EP controller */
>  	ret = mhi_ep_register_controller(mhi_cntrl, info->config);
> diff --git a/include/linux/mhi_ep.h b/include/linux/mhi_ep.h
> index c3a0685..e353c429 100644
> --- a/include/linux/mhi_ep.h
> +++ b/include/linux/mhi_ep.h
> @@ -137,6 +137,7 @@ struct mhi_ep_cntrl {
>  			   void __iomem *virt, size_t size);
>  	int (*read_from_host)(struct mhi_ep_cntrl *mhi_cntrl, u64 from, void *to, size_t size);
>  	int (*write_to_host)(struct mhi_ep_cntrl *mhi_cntrl, void *from, u64 to, size_t size);
> +	int (*wakeup_host)(struct mhi_ep_cntrl *mhi_cntrl);
>  
>  	enum mhi_state mhi_state;
>  
> -- 
> 2.7.4
> 

-- 
மணிவண்ணன் சதாசிவம்
