Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1181F7EEE55
	for <lists+linux-pci@lfdr.de>; Fri, 17 Nov 2023 10:19:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230264AbjKQJTY (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 17 Nov 2023 04:19:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229927AbjKQJTX (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 17 Nov 2023 04:19:23 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7F0AB7;
        Fri, 17 Nov 2023 01:19:19 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DAF80C433C8;
        Fri, 17 Nov 2023 09:19:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1700212759;
        bh=RxScKe8pP/0RRfA5t2i4gA3ytESPHO43RFRdj7OBitM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=GP9AAZOocEWBJNT+8FIIWcGKwqPqXTlUoYR8e7SIIkdljR1n+5J84lDU0V8m2sz79
         6gWpm5IGrLnIENC1lQ7pHECCLElCCpERAdE13zxjlIeuiFQNEKQbYXPtEMDv5Owmix
         P2gvVo+dlf+6pxSxfZ98jJApZKIZz6nbTeKOZ6b6tl2JOHknMXS+/WQvCI2fOLdOCg
         lyD/8cVBVWjyqSEJVoKffDiqUkwXnX13PtNT6NrLExM9qFPgQUPqn76RJpok0D6z66
         be1cAEwWk92UYlLh/GnBLBYh1zq2XKw+n8R0hiNHLsSXB5AWeVxUtkWcrQ4YmQP33m
         vPXa1eliMPHIA==
Date:   Fri, 17 Nov 2023 14:49:11 +0530
From:   Manivannan Sadhasivam <mani@kernel.org>
To:     Serge Semin <fancer.lancer@gmail.com>
Cc:     Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        lpieralisi@kernel.org, kw@linux.com, robh@kernel.org,
        bhelgaas@google.com, jingoohan1@gmail.com,
        gustavo.pimentel@synopsys.com, linux-pci@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org
Subject: Re: [PATCH v2 4/6] PCI: dwc: Add dw_pcie_ep_{read,write}_dbi[2]
 helpers
Message-ID: <20231117091911.GF250770@thinkpad>
References: <20231114055456.2231990-1-yoshihiro.shimoda.uh@renesas.com>
 <20231114055456.2231990-5-yoshihiro.shimoda.uh@renesas.com>
 <qpw6zgqnxvnxqwzilelaev26xmjebimnyyvc5jzfgdyqgvjyvq@sne5unvwbea4>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <qpw6zgqnxvnxqwzilelaev26xmjebimnyyvc5jzfgdyqgvjyvq@sne5unvwbea4>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Nov 14, 2023 at 01:52:24PM +0300, Serge Semin wrote:
> On Tue, Nov 14, 2023 at 02:54:54PM +0900, Yoshihiro Shimoda wrote:
> > The current code calculated some dbi[2] registers' offset by calling
> > dw_pcie_ep_get_dbi[2]_offset() in each function. To improve code
> > readability, add dw_pcie_ep_{read,write}_dbi[2} and some data-width
> > related helpers.
> 
> Nice update. Thanks!
> Reviewed-by: Serge Semin <fancer.lancer@gmail.com>
> 
> I'll replicate my v1 nitpick regarding the accessors location here so
> the maintainers would decide whether it worth being taken into
> account.
> 
> > 
> > Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
> > ---
> >  .../pci/controller/dwc/pcie-designware-ep.c   | 231 ++++++++++--------
> >  1 file changed, 129 insertions(+), 102 deletions(-)
> > 
> > diff --git a/drivers/pci/controller/dwc/pcie-designware-ep.c b/drivers/pci/controller/dwc/pcie-designware-ep.c
> > index 1100671db887..2b5b5b0fa7a9 100644
> > --- a/drivers/pci/controller/dwc/pcie-designware-ep.c
> > +++ b/drivers/pci/controller/dwc/pcie-designware-ep.c
> > @@ -65,24 +65,88 @@ static unsigned int dw_pcie_ep_get_dbi2_offset(struct dw_pcie_ep *ep, u8 func_no
> >  	return dbi2_offset;
> >  }
> >  
> > +static u32 dw_pcie_ep_read_dbi(struct dw_pcie_ep *ep, u8 func_no, u32 reg,
> > +			       size_t size)
> > +{
> > +	unsigned int offset = dw_pcie_ep_get_dbi_offset(ep, func_no);
> > +	struct dw_pcie *pci = to_dw_pcie_from_ep(ep);
> > +
> > +	return dw_pcie_read_dbi(pci, offset + reg, size);
> > +}
> > +
> > +static void dw_pcie_ep_write_dbi(struct dw_pcie_ep *ep, u8 func_no, u32 reg,
> > +				 size_t size, u32 val)
> > +{
> > +	unsigned int offset = dw_pcie_ep_get_dbi_offset(ep, func_no);
> > +	struct dw_pcie *pci = to_dw_pcie_from_ep(ep);
> > +
> > +	dw_pcie_write_dbi(pci, offset + reg, size, val);
> > +}
> > +
> > +static void dw_pcie_ep_write_dbi2(struct dw_pcie_ep *ep, u8 func_no, u32 reg,
> > +				  size_t size, u32 val)
> > +{
> > +	unsigned int offset = dw_pcie_ep_get_dbi2_offset(ep, func_no);
> > +	struct dw_pcie *pci = to_dw_pcie_from_ep(ep);
> > +
> > +	dw_pcie_write_dbi2(pci, offset + reg, size, val);
> > +}
> > +
> > +static inline void dw_pcie_ep_writel_dbi(struct dw_pcie_ep *ep, u8 func_no,
> > +					 u32 reg, u32 val)
> > +{
> > +	dw_pcie_ep_write_dbi(ep, func_no, reg, 0x4, val);
> > +}
> > +
> > +static inline u32 dw_pcie_ep_readl_dbi(struct dw_pcie_ep *ep, u8 func_no,
> > +				       u32 reg)
> > +{
> > +	return dw_pcie_ep_read_dbi(ep, func_no, reg, 0x4);
> > +}
> > +
> > +static inline void dw_pcie_ep_writew_dbi(struct dw_pcie_ep *ep, u8 func_no,
> > +					 u32 reg, u16 val)
> > +{
> > +	dw_pcie_ep_write_dbi(ep, func_no, reg, 0x2, val);
> > +}
> > +
> > +static inline u16 dw_pcie_ep_readw_dbi(struct dw_pcie_ep *ep, u8 func_no,
> > +				       u32 reg)
> > +{
> > +	return dw_pcie_ep_read_dbi(ep, func_no, reg, 0x2);
> > +}
> > +
> > +static inline void dw_pcie_ep_writeb_dbi(struct dw_pcie_ep *ep, u8 func_no,
> > +					 u32 reg, u8 val)
> > +{
> > +	dw_pcie_ep_write_dbi(ep, func_no, reg, 0x1, val);
> > +}
> > +
> > +static inline u8 dw_pcie_ep_readb_dbi(struct dw_pcie_ep *ep, u8 func_no,
> > +				      u32 reg)
> > +{
> > +	return dw_pcie_ep_read_dbi(ep, func_no, reg, 0x1);
> > +}
> > +
> > +static inline void dw_pcie_ep_writel_dbi2(struct dw_pcie_ep *ep, u8 func_no,
> > +					  u32 reg, u32 val)
> > +{
> > +	dw_pcie_ep_write_dbi2(ep, func_no, reg, 0x4, val);
> > +}
> > +
> 
> My comment was:
> 
> > From: Serge Semin, Sent: Monday, November 13, 2023 9:41 PM
> > > I am not sure whether the methods above are supposed to be defined
> > > here instead of being moved to the "pcie-designware.h" header file
> > > together with dw_pcie_ep_get_dbi2_offset() and
> > > dw_pcie_ep_get_dbi_offset(). The later place seems more suitable
> > > seeing the accessors are generic, look similar to the
> > > dw_pcie_{write,read}_dbi{,2}() functions and might be useful in the
> > > platform drivers. On the other hand no LLDDs would have used it
> > > currently. So I'll leave this as a food for thoughts for the driver
> > > and subsystem maintainers.
> 
> Yoshihiro replied:
> > Perhaps, when a device driver needs to use these functions actually,
> > we can move these functions to pcie-designware.h, I think.
> 

I agree with you. Since these are read/write accessors, it would be better to
move them to the header file instead.

- Mani

-- 
மணிவண்ணன் சதாசிவம்
