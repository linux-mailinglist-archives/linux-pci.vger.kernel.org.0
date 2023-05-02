Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 44F2D6F49B6
	for <lists+linux-pci@lfdr.de>; Tue,  2 May 2023 20:33:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229618AbjEBSdI (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 2 May 2023 14:33:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233647AbjEBSdH (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 2 May 2023 14:33:07 -0400
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DEAE3198A
        for <linux-pci@vger.kernel.org>; Tue,  2 May 2023 11:33:05 -0700 (PDT)
Received: by mail-pf1-x42d.google.com with SMTP id d2e1a72fcca58-63b7588005fso3351200b3a.0
        for <linux-pci@vger.kernel.org>; Tue, 02 May 2023 11:33:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1683052385; x=1685644385;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=iIyzQR1hA+SZiBoW0ns3e+WZwCO2+2PQI30d1oTt8hw=;
        b=jWEiarhJlxAb5VKkiipfBVn64qBGy2rQ+1f0ahz3GM4FiBdLJizcz0IS2m99Igjr9o
         4Y93hL5Vofu+/KdCPGyMcfUOpChSqFQ2h4sKsqd2fakejFKJjFlwgC+aP2DTEPXuhpEE
         fYVphWI2owdPQtiHxwR7XzWrTfIEF3c4EVlEsuU/2obctgHGNFNoxy/WTmLE4erCmkvB
         pswe+6kk44npx4lvlkgQt33nKgiJUZbFChRrblz6GEiBaJ9ptgIbh/kICbK4Mv6GIZFA
         eBMd1wwhqpsf1dCcCxrI9aNYHUm1iaYUFTpUUUJpNd5YWBxOCvZsZ2Y6NnqNuevAMGYB
         21HA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683052385; x=1685644385;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iIyzQR1hA+SZiBoW0ns3e+WZwCO2+2PQI30d1oTt8hw=;
        b=NwGqn+iMNE0HmkMC3ojsQrMjH0Q/1JSpFguanC0wh4pnoxB67XduHuMN2YMejMGEkv
         TD9XBg/mY2DjLEHJo50hGhal3qpWQDrrOUMq/VgFNf6M9mGn/prL1AZoDF05N6RWBTk3
         BfKjJggpNyqg76e8orwpoCwjszX4JB7hax3GoQYZL+UcMXDzYDWJluqNtjwv1iCSgdLh
         cl6chkrdrRt08YaTTOvVNvapqiJBzb4oPB/DNaWYivwIq6OyvG31lmwZgBn5C50PaTan
         mZ5Qo4JuirI3BAsydCzRo79RRV1jXPJvWKQ0QNJ8FRMzzmeT/0E4eCqoayhvPtVj+3/M
         HcJA==
X-Gm-Message-State: AC+VfDwUuHl0I/piNMs4BkCup+D9trxcth6RemF2LpoTxrZIBfRMchJT
        A/KzXis1a7TSGNdFGuu/MAUmaA==
X-Google-Smtp-Source: ACHHUZ6ksmH5nlXhqZVMRbjzkhebQW1vUDXheU99mFw5d/H40fmgpS0aLiaY+e9LO5GO9IYG9MxZrQ==
X-Received: by 2002:a05:6a00:1916:b0:641:3ca2:1aec with SMTP id y22-20020a056a00191600b006413ca21aecmr18407903pfi.27.1683052385126;
        Tue, 02 May 2023 11:33:05 -0700 (PDT)
Received: from google.com (41.183.143.34.bc.googleusercontent.com. [34.143.183.41])
        by smtp.gmail.com with ESMTPSA id x35-20020a056a0018a300b0063b6cccd5dfsm22211680pfh.195.2023.05.02.11.33.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 May 2023 11:33:04 -0700 (PDT)
Date:   Wed, 3 May 2023 00:02:55 +0530
From:   Ajay Agarwal <ajayagarwal@google.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        Vidya Sagar <vidyas@nvidia.com>,
        Nikhil Devshatwar <nikhilnd@google.com>,
        Manu Gautam <manugautam@google.com>,
        "David E. Box" <david.e.box@linux.intel.com>,
        Kai-Heng Feng <kai.heng.feng@canonical.com>,
        Michael Bottini <michael.a.bottini@linux.intel.com>,
        linux-pci@vger.kernel.org
Subject: Re: [PATCH 1/3] PCI/ASPM: Disable ASPM_STATE_L1 only when class
 driver disables L1 ASPM
Message-ID: <ZFFXV5Vvq8WPY0h2@google.com>
References: <ZFEENUdnDPCvwtVS@google.com>
 <20230502160722.GA691169@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230502160722.GA691169@bhelgaas>
X-Spam-Status: No, score=-14.5 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,FSL_HELO_FAKE,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, May 02, 2023 at 11:07:22AM -0500, Bjorn Helgaas wrote:
> On Tue, May 02, 2023 at 06:08:13PM +0530, Ajay Agarwal wrote:
> > On Mon, May 01, 2023 at 12:21:14PM -0500, Bjorn Helgaas wrote:
> > > On Tue, Apr 11, 2023 at 04:40:32PM +0530, Ajay Agarwal wrote:
> > > > Currently the aspm driver sets ASPM_STATE_L1 as well as
> > > > ASPM_STATE_L1SS bits when the class driver disables L1.
> > > 
> > > I would have said just "driver" -- do you mean something different by
> > > using "class driver"?  The callers I see are garden-variety drivers
> > > for individual devices like hci_bcm4377, xillybus_pcie, e1000e, jme,
> > > etc.
> >
> > No, I do not mean anything different by "class driver". I just wanted
> > to name the caller drivers of the ASPM APIs as something other than
> > just "driver". Do you want me to change this to "driver" ?
> 
> Yes, please, I think "driver" by itself is sufficient.  IIUC, "class
> driver" generally refers to a generic or abstract driver that provides
> a common interface to a variety of different devices.  This interface
> could be used by such a class driver or by the driver for a specific
> device, but the type of driver is not relevant to this patch.
> 
> Bjorn

Ack. Will do in the next revision.
