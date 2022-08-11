Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D231C59055D
	for <lists+linux-pci@lfdr.de>; Thu, 11 Aug 2022 19:06:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234657AbiHKRGO (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 11 Aug 2022 13:06:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236576AbiHKRFk (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 11 Aug 2022 13:05:40 -0400
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9C64EA8B5
        for <linux-pci@vger.kernel.org>; Thu, 11 Aug 2022 09:36:11 -0700 (PDT)
Received: by mail-pj1-x102e.google.com with SMTP id c19-20020a17090ae11300b001f2f94ed5c6so5599250pjz.1
        for <linux-pci@vger.kernel.org>; Thu, 11 Aug 2022 09:36:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc;
        bh=yQQeBGMFRhJHqkBrliQLlLMhGDgr93041o3JbsxLdP0=;
        b=f0Y97m5uFoTjMQUKrRexPwcFC1iookwhVumI2WNsBH80pPBuXyNElI2rG2qBDCu7qO
         T8yCFTJPq18Cy0348pc+Cucq+jrx/U9A5fJxVUAqbo3xN6D+yWmzsx2oTWBi4K67rCTW
         MpeJ9YRpcF1VmoSImPpcbbRZgrjizRI0GlbF1NakZaXKLvJ5P4EoTBxPEFjzbXFhGvOT
         ArR+i6xGVWVk5PcJZ3C6Pj4lj7tpIsNMzM51tkl5qITjXhuY5luSRapytx3Uqh+TH/5H
         yNePBOZb6UYl3L3zMygzFcOyTTWw6Mv8x8AhtkNMceofVPrOlKHUSKUurjKysT7amwoK
         h9hA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc;
        bh=yQQeBGMFRhJHqkBrliQLlLMhGDgr93041o3JbsxLdP0=;
        b=z4eeyLFgD4malEmMipURHDRv/xQ1GWQLRgYJAzjksHdNgx0cNqfWRFh9DBteJqR91m
         wIkW74JDjEvZZpcRo92Gtu35hULHrtRrUwdF2HpPZ+sySXNquys5K4lssZ+Tr4570eUr
         LHMNkLlNLOgxKtDDCQOtWBxQwe6k3obRw+rHwmNkg+N6nikxQU3P6l2qE5/KVf+sRL2F
         YvteQ2iSGN7CaofRyLZTFQ6RZD8IoxhWRoJaAiJzftXAjKMRcsy6bqS6+PJqkGHDwKHq
         nO/6gNT9ARF/YNNgJHSncjkDcnoiU02rfDah4CnILQkKvX0Ezmxg1Zf8qqv9w7Zw4wjH
         x6FA==
X-Gm-Message-State: ACgBeo1KrisHMCBvXtcIXSLuWW2xk73tUUJBchJcUf5LPpmvxkvOgwfU
        yJRn3Dp+jcR5Bp9gJ49GA0HEwA==
X-Google-Smtp-Source: AA6agR4X3X0Tp65+0VAvDzI0xmtNZkiBcym4hl6k5bgk2jVKYmgD/SdQuv9S2E16swSiddLHC9c7vw==
X-Received: by 2002:a17:902:e746:b0:16e:f7cf:671f with SMTP id p6-20020a170902e74600b0016ef7cf671fmr109605plf.168.1660235770052;
        Thu, 11 Aug 2022 09:36:10 -0700 (PDT)
Received: from google.com (201.215.168.34.bc.googleusercontent.com. [34.168.215.201])
        by smtp.gmail.com with ESMTPSA id 6-20020a170902c10600b0016b81679c31sm15039246pli.213.2022.08.11.09.36.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Aug 2022 09:36:09 -0700 (PDT)
Date:   Thu, 11 Aug 2022 16:36:04 +0000
From:   William McVicker <willmcvicker@google.com>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Jingoo Han <jingoohan1@gmail.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>, kernel-team@android.com,
        Vidya Sagar <vidyas@nvidia.com>, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 2/2] PCI: dwc: add support for 64-bit MSI target
 address
Message-ID: <YvUv9Pt5PiLPAuTu@google.com>
References: <20220809180051.1063653-1-willmcvicker@google.com>
 <20220809180051.1063653-3-willmcvicker@google.com>
 <YvTKTCABejYZERnh@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YvTKTCABejYZERnh@infradead.org>
X-Spam-Status: No, score=-12.5 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,FSL_HELO_FAKE,HK_RANDOM_ENVFROM,HK_RANDOM_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 08/11/2022, Christoph Hellwig wrote:
> On Tue, Aug 09, 2022 at 06:00:50PM +0000, Will McVicker wrote:
> > +	bool msi_64b = false;
> 
> Spellt out bit here?
> 
> > +	msi_capabilities = dw_pcie_msi_capabilities(pci);
> > +	if (msi_capabilities & PCI_MSI_FLAGS_ENABLE)
> > +		msi_64b = msi_capabilities & PCI_MSI_FLAGS_64BIT ? true : false;
> 
> No need for the tenary operator here:
> 
> 		msi_64bit = msi_capabilities & PCI_MSI_FLAGS_64BIT;

Thanks for the suggestions. I'll update in the next patchset.
