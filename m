Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 329127226E6
	for <lists+linux-pci@lfdr.de>; Mon,  5 Jun 2023 15:08:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230088AbjFENIl (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 5 Jun 2023 09:08:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230488AbjFENIl (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 5 Jun 2023 09:08:41 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F728CD;
        Mon,  5 Jun 2023 06:08:40 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D5C2F61403;
        Mon,  5 Jun 2023 13:08:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C64A1C433D2;
        Mon,  5 Jun 2023 13:08:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685970519;
        bh=C5s8ZR2SYuPi/f9XTWMiXsaNSj08rkdKfPc4RPMosRw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=NDVYulSsKQkpyLLhPz1Bhoru8SLw2qNbDwZWB0sAStvVCcJaHj6fsJCSKzUEN8vRn
         +5nkLIyfmozMkfEOR/HILic3zHMKC+8u+opd7eIrC/U5dhEV5h6eQfCrRvI4pgGIYD
         dmcI10vyQ8sGXYSMZvHOG56R8aNlAqJ7wDXOZRb0FBXqrNdMjnAQrEP+nQSlg0IwLA
         L+lLWGsPlvWTXsAikzFzhmaNlZT1n5NGgs8SrmKLjwfLFjIbM3UtdPRpuB0ZrcIbW1
         Jntf/szUDKcxR9CnHlC4kU2tmwWUg1VneP7oLflqFKnjucrHeT/e5BKd+/pb2EpGzT
         2SozDp06GIi9A==
Date:   Mon, 5 Jun 2023 15:08:33 +0200
From:   Lorenzo Pieralisi <lpieralisi@kernel.org>
To:     Damien Le Moal <dlemoal@kernel.org>
Cc:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        kw@linux.com, kishon@kernel.org, bhelgaas@google.com,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH v6 2/9] PCI: endpoint: Pass EPF device ID to the probe
 function
Message-ID: <ZH3eUQaIvWAQLI9A@lpieralisi>
References: <20230602114756.36586-1-manivannan.sadhasivam@linaro.org>
 <20230602114756.36586-3-manivannan.sadhasivam@linaro.org>
 <fdf5ea08-f3a1-3c9f-66a3-1cfa3743dae2@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fdf5ea08-f3a1-3c9f-66a3-1cfa3743dae2@kernel.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Jun 02, 2023 at 09:13:25PM +0900, Damien Le Moal wrote:
> On 6/2/23 20:47, Manivannan Sadhasivam wrote:
> > Currently, the EPF probe function doesn't get the device ID argument needed
> > to correctly identify the device table ID of the EPF device.
> > 
> > When multiple entries are added to the "struct pci_epf_device_id" table,
> > the probe function needs to identify the correct one. This is achieved by
> > modifying the pci_epf_match_id() function to return the match ID pointer
> > and passing it to the driver's probe function.
> > 
> > pci_epf_device_match() function can return bool based on the return value
> > of pci_epf_match_id().
> > 
> > Reviewed-by: Kishon Vijay Abraham I <kishon@kernel.org>
> > Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> 
> [...]
> 
> >  static int pci_epf_device_match(struct device *dev, struct device_driver *drv)
> > @@ -510,8 +510,12 @@ static int pci_epf_device_match(struct device *dev, struct device_driver *drv)
> >  	struct pci_epf *epf = to_pci_epf(dev);
> >  	struct pci_epf_driver *driver = to_pci_epf_driver(drv);
> >  
> > -	if (driver->id_table)
> > -		return pci_epf_match_id(driver->id_table, epf);
> > +	if (driver->id_table) {
> > +		if (pci_epf_match_id(driver->id_table, epf))
> > +			return true;
> > +		else
> > +			return false;
> 
> You prefer keeping this pattern ?
> 
> return pci_epf_match_id(driver->id_table, epf) != NULL;
> 
> is no much nicer !

s/no/so

Yes it is, I can change it myself to spare Mani few cycles.

Lorenzo

> 
> Anyway:
> 
> Reviewed-by: Damien Le Moal <dlemoal@kernel.org>
> 
> -- 
> Damien Le Moal
> Western Digital Research
> 
