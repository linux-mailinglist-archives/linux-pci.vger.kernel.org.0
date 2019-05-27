Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6289E2B958
	for <lists+linux-pci@lfdr.de>; Mon, 27 May 2019 19:15:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726545AbfE0RP1 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 27 May 2019 13:15:27 -0400
Received: from mail-lf1-f68.google.com ([209.85.167.68]:35731 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726432AbfE0RP1 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 27 May 2019 13:15:27 -0400
Received: by mail-lf1-f68.google.com with SMTP id a25so2716576lfg.2
        for <linux-pci@vger.kernel.org>; Mon, 27 May 2019 10:15:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=bQYcUfzJ2eNZWZPGMl/JEm3foS8Vd5oiqQcXqPz07kw=;
        b=IwyLnWMZV/lpbMMff8AmQ9B448MJe0hJfxwb0ybe6SaMC0lAuX1ECzmNaHNcN0Fa8/
         TZkEKkQQbEF1yrnnVZ0455tihokSvF0U2ll4z1nsJYIk4r89GxDcO4BKABRGZ35FeOHa
         JRcgJyHcrufrWvWj/HC80jNc8vqhmNVdGzyDsLPxwjAu+UasKMS9VjdT7wc1ZuuQIQLJ
         KIUbeCkVLS1APL5fNmRXP+Ad1nqkwvGH4TYMMeAPTLudHITt/L/lOSWGK2+axIJeIH+p
         sbxzFZSFJr8mPrv4POl+WTkJJ2aQA8CUgilP6GATfXEHzDBhATBuQWF3UXVkj5mnqshm
         ACtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=bQYcUfzJ2eNZWZPGMl/JEm3foS8Vd5oiqQcXqPz07kw=;
        b=KAhH69waGdQoNuj8bq3KxPQcp5gh7mfw9tcITr98yGUAjtKGrHvTBm+pr+JAJUlm6g
         tOi8Z2cnhdQSeiQOF6ty31S+Gjyjxohd2E5bWqXhNDKiMQQHy6zMaKrpjnXRUPwTUtuk
         eShs/5gDuoJye1vjwYbt78dPVtSI23qrcXGe767R2Zy5XLpf30Iy25iIdqnlWff+ImTM
         onvwd902gH/e1sZjsLe6JNxXKIp4sze5oocLuRRx9IUJUJNXXELhbQNRiTMJiBfOJnIL
         s+1iXJSQvnsAMOjvdNZI+0G2QG65Tp2dhvngx/sb2JVt7JiLkwCXDKmKwHg+H7w+0U2v
         +FpQ==
X-Gm-Message-State: APjAAAUPNnRdhYazk63NXg08yPoR8p2TPeQYide5pJ5uOFj+9jGlYqLv
        4cy04PNSBBTwDNJxbq6BmQ7iLg==
X-Google-Smtp-Source: APXvYqwsEdFVhYeFfyhJrlzePl5Iuv+PqsOCTx5ry/jO/7Fo47egn7d+efqzPXCU53fFtTFc+KItfg==
X-Received: by 2002:ac2:510b:: with SMTP id q11mr1072378lfb.11.1558977325355;
        Mon, 27 May 2019 10:15:25 -0700 (PDT)
Received: from centauri (m83-185-80-163.cust.tele2.se. [83.185.80.163])
        by smtp.gmail.com with ESMTPSA id t13sm2382792lji.47.2019.05.27.10.15.23
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 27 May 2019 10:15:24 -0700 (PDT)
Date:   Mon, 27 May 2019 19:15:21 +0200
From:   Niklas Cassel <niklas.cassel@linaro.org>
To:     Marc Gonzalez <marc.w.gonzalez@free.fr>
Cc:     Stanimir Varbanov <svarbanov@mm-sol.com>,
        Andy Gross <agross@kernel.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        PCI <linux-pci@vger.kernel.org>,
        MSM <linux-arm-msm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] PCI: qcom: Ensure that PERST is asserted for at least
 100 ms
Message-ID: <20190527171521.GA7936@centauri>
References: <20190523194409.17718-1-niklas.cassel@linaro.org>
 <5d743969-e763-95c5-6763-171a8ecf66d8@free.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5d743969-e763-95c5-6763-171a8ecf66d8@free.fr>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, May 24, 2019 at 02:43:00PM +0200, Marc Gonzalez wrote:
> On 23/05/2019 21:44, Niklas Cassel wrote:
> 
> > Currently, there is only a 1 ms sleep after asserting PERST.
> > 
> > Reading the datasheets for different endpoints, some require PERST to be
> > asserted for 10 ms in order for the endpoint to perform a reset, others
> > require it to be asserted for 50 ms.
> > 
> > Several SoCs using this driver uses PCIe Mini Card, where we don't know
> > what endpoint will be plugged in.
> > 
> > The PCI Express Card Electromechanical Specification specifies:
> > "On power up, the deassertion of PERST# is delayed 100 ms (TPVPERL) from
> > the power rails achieving specified operating limits."
> > 
> > Add a sleep of 100 ms before deasserting PERST, in order to ensure that
> > we are compliant with the spec.
> > 
> > Signed-off-by: Niklas Cassel <niklas.cassel@linaro.org>
> > ---
> >  drivers/pci/controller/dwc/pcie-qcom.c | 2 ++
> >  1 file changed, 2 insertions(+)
> > 
> > diff --git a/drivers/pci/controller/dwc/pcie-qcom.c b/drivers/pci/controller/dwc/pcie-qcom.c
> > index 0ed235d560e3..cae24376237c 100644
> > --- a/drivers/pci/controller/dwc/pcie-qcom.c
> > +++ b/drivers/pci/controller/dwc/pcie-qcom.c
> > @@ -1110,6 +1110,8 @@ static int qcom_pcie_host_init(struct pcie_port *pp)
> >  	if (IS_ENABLED(CONFIG_PCI_MSI))
> >  		dw_pcie_msi_init(pp);
> >  
> > +	/* Ensure that PERST has been asserted for at least 100 ms */
> > +	msleep(100);
> >  	qcom_ep_reset_deassert(pcie);
> >  
> >  	ret = qcom_pcie_establish_link(pcie);
> 
> Currently, qcom_ep_reset_assert() and qcom_ep_reset_deassert() both include
> a call to usleep_range() of 1.0 to 1.5 ms
> 
> Can we git rid of both if we sleep 100 ms before qcom_ep_reset_deassert?

These two sleeps after asserting/deasserting reset in qcom_ep_reset_assert()/
qcom_ep_reset_deassert() matches the sleeps in:
https://source.codeaurora.org/quic/la/kernel/msm-4.14/tree/drivers/pci/host/pci-msm.c?h=LA.UM.7.1.r1-14000-sm8150.0#n1942

and

https://source.codeaurora.org/quic/la/kernel/msm-4.14/tree/drivers/pci/host/pci-msm.c?h=LA.UM.7.1.r1-14000-sm8150.0#n1949

I would rather not remove these since that might affect existing devices.


This new sleep matches matches the sleep in:
https://source.codeaurora.org/quic/la/kernel/msm-4.14/tree/drivers/pci/host/pci-msm.c?h=LA.UM.7.1.r1-14000-sm8150.0#n3926

> 
> Should the msleep() call be included in one of the two wrappers?

This new sleep could be moved into qcom_ep_reset_deassert(),
added before the gpiod_set_value_cansleep(pcie->reset, 0) call,
if Stanimir prefers it to be placed there instead.


Kind regards,
Niklas
