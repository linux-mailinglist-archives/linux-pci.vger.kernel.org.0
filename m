Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 54DEB4C2061
	for <lists+linux-pci@lfdr.de>; Thu, 24 Feb 2022 01:09:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245137AbiBXAJb (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 23 Feb 2022 19:09:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243114AbiBXAJa (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 23 Feb 2022 19:09:30 -0500
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BACEE5F26D
        for <linux-pci@vger.kernel.org>; Wed, 23 Feb 2022 16:09:01 -0800 (PST)
Received: by mail-pl1-x62f.google.com with SMTP id x11so228835pll.10
        for <linux-pci@vger.kernel.org>; Wed, 23 Feb 2022 16:09:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=VCdc9GEAmO266OC+X01dJhtydsgrTXY5Kn2FZrQL71c=;
        b=MAnsIIS4IB/GthG2Mrc7kTIO2V0rECTyRW0Ci5XTvXpBBt80yIANXz1/8CqotsOh3a
         7YmODyTqTvRbxfUHyW+tQjsnm8M7NJcljLbzzYFnlcHIvnT6NbIfEIs+A8+t1zUflT2M
         RXUGd36BUC8O64DuTZj7JefJ0hWrIyktqjPLNoAKKTajIVpzuPQOmaEGvxephGcgNMLm
         FihTsRf/IWntlz1BOtTUfE5hSLy55IDlO+ptedmiW4TpgHHBHuy1xfPeDELCxv4Qvkwk
         X0r8uk3yIaH82SQVunnqS3eYvfKYlRBkMJ2FJU+h9KD5VzXliWO+TXslLe8aUDaFENcp
         Oerw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=VCdc9GEAmO266OC+X01dJhtydsgrTXY5Kn2FZrQL71c=;
        b=IMAI0t++ORmBvJBWxp6XmaC5DJc0nrzuXbKIxCFRTZ8OJtyNA36mYzc4daAuuP1nuU
         KgJ7j0LL76t2wBf3F6AqIcCZcwYZcU7B48VqscW7hhQxFUFbWPlBXp1b9MHIj7ukitNB
         /lOlbcYNHrkC1A3wVkdkLvEscNjfL+/OknVsYkJPz3ClMnfBX+aSfkQHm0wPIdeMeRdv
         nZuUuVitF98d4Qv8Ho2quI24qWv7ARxR/vN89sJb2WFlflCPCMDSUPzjHniE5almCc2h
         81uwCHin4Rah9wdE+qLf4wo149hkDU5c8fHSQj4Iv8svpyu0/+qBdV1IRsrVcHU1yHdP
         1oEg==
X-Gm-Message-State: AOAM533HHSACtrErC8TFU8OvoJOwSkc+RTTJZkAMi0dIWdWMS71KgkYx
        UtyBvs3asvZdlp6Ut0WgxOD8f5cAJ+wiBTUpFpuG+A==
X-Google-Smtp-Source: ABdhPJwid12NWGDXBt5wmyt+BeP14CZhJpyGGHck1QL2sP52n49iYOfNLhCfmU8ktcqcvkUCbiExq+2655CajEUKb9c=
X-Received: by 2002:a17:90a:990c:b0:1bc:3c9f:2abe with SMTP id
 b12-20020a17090a990c00b001bc3c9f2abemr64928pjp.220.1645661341096; Wed, 23 Feb
 2022 16:09:01 -0800 (PST)
MIME-Version: 1.0
References: <20220128002707.391076-1-ben.widawsky@intel.com> <20220128002707.391076-13-ben.widawsky@intel.com>
In-Reply-To: <20220128002707.391076-13-ben.widawsky@intel.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Wed, 23 Feb 2022 16:08:50 -0800
Message-ID: <CAPcyv4hZETHNa2Lw7ug8=c=PnNVDP4KRoaDUL8nyD7SAarTohw@mail.gmail.com>
Subject: Re: [PATCH v3 12/14] cxl: Program decoders for regions
To:     Ben Widawsky <ben.widawsky@intel.com>
Cc:     linux-cxl@vger.kernel.org, patches@lists.linux.dev,
        Alison Schofield <alison.schofield@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Bjorn Helgaas <helgaas@kernel.org>,
        Linux NVDIMM <nvdimm@lists.linux.dev>,
        Linux PCI <linux-pci@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Jan 27, 2022 at 4:27 PM Ben Widawsky <ben.widawsky@intel.com> wrote:
>
> Configure and commit the HDM decoders for the region. Since the region
> driver already was able to walk the topology and build the list of
> needed decoders, all that was needed to finish region setup was to
> actually write the HDM decoder MMIO.
>
> CXL regions appear as linear addresses in the system's physical address
> space. CXL memory devices comprise the storage for the region. In order
> for traffic to be properly routed to the memory devices in the region, a
> set of Host-manged Device Memory decoders must be present. The decoders
> are a piece of hardware defined in the CXL specification.
>
> Signed-off-by: Ben Widawsky <ben.widawsky@intel.com>
>
> ---
> Changes since v2:
> - Fix unwind issue in bind_region introduced in v2
> ---
>  drivers/cxl/core/hdm.c | 209 +++++++++++++++++++++++++++++++++++++++++
>  drivers/cxl/cxl.h      |   3 +
>  drivers/cxl/region.c   |  72 +++++++++++---
>  3 files changed, 272 insertions(+), 12 deletions(-)
>
> diff --git a/drivers/cxl/core/hdm.c b/drivers/cxl/core/hdm.c
> index a28369f264da..66c08d69f7a6 100644
> --- a/drivers/cxl/core/hdm.c
> +++ b/drivers/cxl/core/hdm.c
> @@ -268,3 +268,212 @@ int devm_cxl_enumerate_decoders(struct cxl_hdm *cxlhdm)
>         return 0;
>  }
>  EXPORT_SYMBOL_NS_GPL(devm_cxl_enumerate_decoders, CXL);
> +
> +#define COMMIT_TIMEOUT_MS 10
> +static int wait_for_commit(struct cxl_decoder *cxld)
> +{
> +       const unsigned long end = jiffies + msecs_to_jiffies(COMMIT_TIMEOUT_MS);
> +       struct cxl_port *port = to_cxl_port(cxld->dev.parent);
> +       void __iomem *hdm_decoder;
> +       struct cxl_hdm *cxlhdm;
> +       u32 ctrl;
> +
> +       cxlhdm = dev_get_drvdata(&port->dev);
> +       hdm_decoder = cxlhdm->regs.hdm_decoder;
> +
> +       while (1) {

A live wait is too expensive. Also, given region programming is
writing multiple decoders it would seem to make sense to amortize the
waiting over multiple decoders. I.e. a flow like:

program all decoders
commit all decoders
10ms wait
check all decoder for commit timeouts

> +               ctrl = readl(hdm_decoder +
> +                            CXL_HDM_DECODER0_CTRL_OFFSET(cxld->id));
> +               if (FIELD_GET(CXL_HDM_DECODER0_CTRL_COMMITTED, ctrl))
> +                       break;
> +
> +               if (time_after(jiffies, end)) {
> +                       dev_err(&cxld->dev, "HDM decoder commit timeout %x\n",
> +                               ctrl);
> +                       return -ETIMEDOUT;
> +               }
> +               if ((ctrl & CXL_HDM_DECODER0_CTRL_COMMIT_ERROR) != 0) {
> +                       dev_err(&cxld->dev, "HDM decoder commit error %x\n",
> +                               ctrl);
> +                       return -ENXIO;
> +               }
> +       }
> +
> +       return 0;
> +}
> +
> +/**
> + * cxl_commit_decoder() - Program a configured cxl_decoder
> + * @cxld: The preconfigured cxl decoder.
> + *
> + * A cxl decoder that is to be committed should have been earmarked as enabled.
> + * This mechanism acts as a soft reservation on the decoder.
> + *
> + * Returns 0 if commit was successful, negative error code otherwise.
> + */
> +int cxl_commit_decoder(struct cxl_decoder *cxld)
> +{
> +       u32 ctrl, tl_lo, tl_hi, base_lo, base_hi, size_lo, size_hi;
> +       struct cxl_port *port = to_cxl_port(cxld->dev.parent);
> +       void __iomem *hdm_decoder;
> +       struct cxl_hdm *cxlhdm;
> +       int rc;
> +
> +       /*
> +        * Decoder flags are entirely software controlled and therefore this
> +        * case is purely a driver bug.
> +        */
> +       if (dev_WARN_ONCE(&port->dev, (cxld->flags & CXL_DECODER_F_ENABLE) != 0,
> +                         "Invalid %s enable state\n", dev_name(&cxld->dev)))
> +               return -ENXIO;
> +
> +       cxlhdm = dev_get_drvdata(&port->dev);
> +       hdm_decoder = cxlhdm->regs.hdm_decoder;
> +       ctrl = readl(hdm_decoder + CXL_HDM_DECODER0_CTRL_OFFSET(cxld->id));
> +
> +       /*
> +        * A decoder that's currently active cannot be changed without the
> +        * system being quiesced. While the driver should prevent against this,
> +        * for a variety of reasons the hardware might not be in sync with the
> +        * hardware and so, do not splat on error.
> +        */
> +       size_hi = readl(hdm_decoder +
> +                       CXL_HDM_DECODER0_SIZE_HIGH_OFFSET(cxld->id));
> +       size_lo =
> +               readl(hdm_decoder + CXL_HDM_DECODER0_SIZE_LOW_OFFSET(cxld->id));
> +       if (FIELD_GET(CXL_HDM_DECODER0_CTRL_COMMITTED, ctrl) &&
> +           (size_lo + size_hi)) {
> +               dev_err(&port->dev, "Tried to change an active decoder (%s)\n",
> +                       dev_name(&cxld->dev));
> +               return -EBUSY;
> +       }
> +
> +       u32p_replace_bits(&ctrl, cxl_to_ig(cxld->interleave_granularity),
> +                         CXL_HDM_DECODER0_CTRL_IG_MASK);

Usage of u32p_replace_bits() makes me wonder what is worth preserving
in the old control value? In this case the code is completely
overwriting the old value so it can just do typical updates for a
@ctrl variable initialized to zero at the start. Otherwise a comment
is needed as to what fields in the current @ctrl need to be preserved
after programming granularity, ways, type, and commit.

> +       u32p_replace_bits(&ctrl, cxl_to_eniw(cxld->interleave_ways),
> +                         CXL_HDM_DECODER0_CTRL_IW_MASK);
> +       u32p_replace_bits(&ctrl, 1, CXL_HDM_DECODER0_CTRL_COMMIT);
> +
> +       /* TODO: set based on type */
> +       u32p_replace_bits(&ctrl, 1, CXL_HDM_DECODER0_CTRL_TYPE);
> +
> +       base_lo = GENMASK(31, 28) & lower_32_bits(cxld->decoder_range.start);
> +       base_hi = upper_32_bits(cxld->decoder_range.start);
> +
> +       size_lo = GENMASK(31, 28) & (u32)(range_len(&cxld->decoder_range));

Why the cast vs just lower_32_bits(range_len(&cxld->decoder_range))?

> +       size_hi = upper_32_bits(range_len(&cxld->decoder_range) >> 32);

Isn't this always 0? I would expect upper_32_bits() without the shift.

> +
> +       if (cxld->nr_targets > 0) {
> +               tl_hi = 0;
> +
> +               tl_lo = FIELD_PREP(GENMASK(7, 0), cxld->target[0]->port_id);
> +
> +               if (cxld->interleave_ways > 1)
> +                       tl_lo |= FIELD_PREP(GENMASK(15, 8),
> +                                           cxld->target[1]->port_id);
> +               if (cxld->interleave_ways > 2)
> +                       tl_lo |= FIELD_PREP(GENMASK(23, 16),
> +                                           cxld->target[2]->port_id);
> +               if (cxld->interleave_ways > 3)
> +                       tl_lo |= FIELD_PREP(GENMASK(31, 24),
> +                                           cxld->target[3]->port_id);
> +               if (cxld->interleave_ways > 4)
> +                       tl_hi |= FIELD_PREP(GENMASK(7, 0),
> +                                           cxld->target[4]->port_id);
> +               if (cxld->interleave_ways > 5)
> +                       tl_hi |= FIELD_PREP(GENMASK(15, 8),
> +                                           cxld->target[5]->port_id);
> +               if (cxld->interleave_ways > 6)
> +                       tl_hi |= FIELD_PREP(GENMASK(23, 16),
> +                                           cxld->target[6]->port_id);
> +               if (cxld->interleave_ways > 7)
> +                       tl_hi |= FIELD_PREP(GENMASK(31, 24),
> +                                           cxld->target[7]->port_id);
> +
> +               writel(tl_hi, hdm_decoder + CXL_HDM_DECODER0_TL_HIGH(cxld->id));
> +               writel(tl_lo, hdm_decoder + CXL_HDM_DECODER0_TL_LOW(cxld->id));
> +       } else {
> +               /* Zero out skip list for devices */

Seems unwieldy to mix root and downstream port decoder programming in
the same function as endpoint decoder programming. Let's keep them
separate. They can of course share helpers, but I don't want the
mental strain of reading this function and wondering what context it
is being called, that should be evident from the function name.

> +               writel(0, hdm_decoder + CXL_HDM_DECODER0_TL_HIGH(cxld->id));
> +               writel(0, hdm_decoder + CXL_HDM_DECODER0_TL_LOW(cxld->id));
> +       }
> +
> +       writel(size_hi,
> +              hdm_decoder + CXL_HDM_DECODER0_SIZE_HIGH_OFFSET(cxld->id));
> +       writel(size_lo,
> +              hdm_decoder + CXL_HDM_DECODER0_SIZE_LOW_OFFSET(cxld->id));
> +       writel(base_hi,
> +              hdm_decoder + CXL_HDM_DECODER0_BASE_HIGH_OFFSET(cxld->id));
> +       writel(base_lo,
> +              hdm_decoder + CXL_HDM_DECODER0_BASE_LOW_OFFSET(cxld->id));
> +       writel(ctrl, hdm_decoder + CXL_HDM_DECODER0_CTRL_OFFSET(cxld->id));
> +
> +       rc = wait_for_commit(cxld);

per above, do you think it's workable to have a common wait for all
decoders at least per level of the hierarcy, i.e.:

program root decoders, wait;
program switch decoders, wait;
program endpoint decoders, wait;

> +       if (rc)
> +               return rc;
> +
> +       cxld->flags |= CXL_DECODER_F_ENABLE;
> +
> +#define DPORT_TL_STR "%d %d %d %d %d %d %d %d"
> +#define DPORT(i)                                                               \
> +       (cxld->nr_targets && cxld->interleave_ways > (i)) ?                    \
> +               cxld->target[(i)]->port_id :                                   \
> +                     -1
> +#define DPORT_TL                                                               \
> +       DPORT(0), DPORT(1), DPORT(2), DPORT(3), DPORT(4), DPORT(5), DPORT(6),  \
> +               DPORT(7)
> +
> +       dev_dbg(&cxld->dev,
> +               "%s (depth %d)\n\tBase %pa\n\tSize %llu\n\tIG %u (%ub)\n\tENIW %u (x%u)\n\tTargetList: \n" DPORT_TL_STR,
> +               dev_name(&port->dev), port->depth, &cxld->decoder_range.start,
> +               range_len(&cxld->decoder_range),
> +               cxl_to_ig(cxld->interleave_granularity),
> +               cxld->interleave_granularity,
> +               cxl_to_eniw(cxld->interleave_ways), cxld->interleave_ways,
> +               DPORT_TL);
> +#undef DPORT_TL
> +#undef DPORT
> +#undef DPORT_TL_STR

It just seems like all of this data is available in sysfs, does the
kernel need to print it?

> +       return 0;
> +}
> +EXPORT_SYMBOL_GPL(cxl_commit_decoder);

EXPOER_SYMBOL_NS_GPL

> +
> +/**
> + * cxl_disable_decoder() - Disables a decoder
> + * @cxld: The active cxl decoder.
> + *
> + * CXL decoders (as of 2.0 spec) have no way to deactivate them other than to
> + * set the size of the HDM to 0. This function will clear all registers, and if
> + * the decoder is active, commit the 0'd out registers.
> + */
> +void cxl_disable_decoder(struct cxl_decoder *cxld)
> +{
> +       struct cxl_port *port = to_cxl_port(cxld->dev.parent);
> +       void __iomem *hdm_decoder;
> +       struct cxl_hdm *cxlhdm;
> +       u32 ctrl;
> +
> +       cxlhdm = dev_get_drvdata(&port->dev);
> +       hdm_decoder = cxlhdm->regs.hdm_decoder;
> +       ctrl = readl(hdm_decoder + CXL_HDM_DECODER0_CTRL_OFFSET(cxld->id));
> +
> +       if (dev_WARN_ONCE(&port->dev, (cxld->flags & CXL_DECODER_F_ENABLE) == 0,
> +                         "Invalid decoder enable state\n"))

Why crash the kernel when trying to disable a disabled decoder?

Where does the "locked" check happen?

> +               return;
> +
> +       cxld->flags &= ~CXL_DECODER_F_ENABLE;
> +
> +       /* There's no way to "uncommit" a committed decoder, only 0 size it */
> +       writel(0, hdm_decoder + CXL_HDM_DECODER0_TL_HIGH(cxld->id));
> +       writel(0, hdm_decoder + CXL_HDM_DECODER0_TL_LOW(cxld->id));

Shouldn't size be first just in case there are cycles still in flight?

> +       writel(0, hdm_decoder + CXL_HDM_DECODER0_SIZE_HIGH_OFFSET(cxld->id));
> +       writel(0, hdm_decoder + CXL_HDM_DECODER0_SIZE_LOW_OFFSET(cxld->id));
> +       writel(0, hdm_decoder + CXL_HDM_DECODER0_BASE_HIGH_OFFSET(cxld->id));
> +       writel(0, hdm_decoder + CXL_HDM_DECODER0_BASE_LOW_OFFSET(cxld->id));
> +
> +       /* If the device isn't actually active, just zero out all the fields */

Why not unconditionally try to commit the new size here? I'd be ok to
keep this policy as you have it, but the comment needs to be changed
to indicate "why?", not "what?" because the code answers the latter.

> +       if (FIELD_GET(CXL_HDM_DECODER0_CTRL_COMMITTED, ctrl))
> +               writel(CXL_HDM_DECODER0_CTRL_COMMIT,
> +                      hdm_decoder + CXL_HDM_DECODER0_CTRL_OFFSET(cxld->id));
> +}
> +EXPORT_SYMBOL_GPL(cxl_disable_decoder);
> diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
> index d70d8c85d05f..f9dab312ed26 100644
> --- a/drivers/cxl/cxl.h
> +++ b/drivers/cxl/cxl.h
> @@ -55,6 +55,7 @@
>  #define   CXL_HDM_DECODER0_CTRL_LOCK BIT(8)
>  #define   CXL_HDM_DECODER0_CTRL_COMMIT BIT(9)
>  #define   CXL_HDM_DECODER0_CTRL_COMMITTED BIT(10)
> +#define   CXL_HDM_DECODER0_CTRL_COMMIT_ERROR BIT(11)
>  #define   CXL_HDM_DECODER0_CTRL_TYPE BIT(12)
>  #define CXL_HDM_DECODER0_TL_LOW(i) (0x20 * (i) + 0x24)
>  #define CXL_HDM_DECODER0_TL_HIGH(i) (0x20 * (i) + 0x28)
> @@ -416,6 +417,8 @@ struct cxl_dport *devm_cxl_add_dport(struct cxl_port *port,
>  struct cxl_dport *cxl_find_dport_by_dev(struct cxl_port *port,
>                                         const struct device *dev);
>  struct cxl_port *ep_find_cxl_port(struct cxl_memdev *cxlmd, unsigned int depth);
> +int cxl_commit_decoder(struct cxl_decoder *cxld);
> +void cxl_disable_decoder(struct cxl_decoder *cxld);
>
>  struct cxl_decoder *to_cxl_decoder(struct device *dev);
>  bool is_cxl_decoder(struct device *dev);
> diff --git a/drivers/cxl/region.c b/drivers/cxl/region.c
> index f748060733dd..ac290677534d 100644
> --- a/drivers/cxl/region.c
> +++ b/drivers/cxl/region.c
> @@ -678,10 +678,52 @@ static int collect_ep_decoders(struct cxl_region *cxlr)
>         return rc;
>  }
>
> -static int bind_region(const struct cxl_region *cxlr)

Try not to change the function signature twice in the same patch
series, i.e. make it non-const at the outset... although I'm not sure
this function survives the new ABI that is assigning decoders to
regions as that would also impact the need to have these ->staged_list
and ->commit_list trackers.

> +static int bind_region(struct cxl_region *cxlr)
>  {
> -       /* TODO: */
> -       return 0;
> +       struct cxl_decoder *cxld, *d;
> +       int rc;
> +
> +       list_for_each_entry_safe(cxld, d, &cxlr->staged_list, region_link) {
> +               rc = cxl_commit_decoder(cxld);
> +               if (!rc) {
> +                       list_move_tail(&cxld->region_link, &cxlr->commit_list);
> +               } else {
> +                       dev_dbg(&cxlr->dev, "Failed to commit %s\n",
> +                               dev_name(&cxld->dev));
> +                       break;
> +               }
> +       }
> +
> +       list_for_each_entry_safe(cxld, d, &cxlr->commit_list, region_link) {
> +               if (rc) {
> +                       cxl_disable_decoder(cxld);
> +                       list_del(&cxld->region_link);
> +               }
> +       }
> +
> +       if (rc)
> +               cleanup_staged_decoders(cxlr);
> +
> +       BUG_ON(!list_empty(&cxlr->staged_list));
> +       return rc;
> +}
> +
> +static void region_unregister(void *dev)
> +{
> +       struct cxl_region *region = to_cxl_region(dev);
> +       struct cxl_decoder *cxld, *d;
> +
> +       if (dev_WARN_ONCE(dev, !list_empty(&region->staged_list),
> +                         "Decoders still staged"))

If I am reading this correctly, why is it a programming error to
unregister a region mid-programming? Certainly userspace could abort a
create attempt and delete after adding some targets, but not others.

> +               cleanup_staged_decoders(region);
> +
> +       /* TODO: teardown the nd_region */
> +
> +       list_for_each_entry_safe(cxld, d, &region->commit_list, region_link) {
> +               cxl_disable_decoder(cxld);
> +               list_del(&cxld->region_link);
> +               cxl_put_decoder(cxld);
> +       }
>  }
>
>  static int cxl_region_probe(struct device *dev)
> @@ -732,20 +774,26 @@ static int cxl_region_probe(struct device *dev)
>                 put_device(&ours->dev);
>
>         ret = collect_ep_decoders(cxlr);
> -       if (ret)
> -               goto err;
> +       if (ret) {
> +               cleanup_staged_decoders(cxlr);
> +               return ret;
> +       }
>
>         ret = bind_region(cxlr);
> -       if (ret)
> -               goto err;
> +       if (ret) {
> +               /* bind_region should cleanup after itself */
> +               if (dev_WARN_ONCE(dev, !list_empty(&cxlr->staged_list),
> +                                 "Region bind failed to cleanup staged decoders\n"))
> +                       cleanup_staged_decoders(cxlr);
> +               if (dev_WARN_ONCE(dev, !list_empty(&cxlr->commit_list),
> +                                 "Region bind failed to cleanup committed decoders\n"))
> +                       region_unregister(&cxlr->dev);
> +               return ret;
> +       }
>
>         cxlr->active = true;
>         dev_info(dev, "Bound");
> -       return 0;
> -
> -err:
> -       cleanup_staged_decoders(cxlr);
> -       return ret;
> +       return devm_add_action_or_reset(dev, region_unregister, dev);
>  }
>
>  static struct cxl_driver cxl_region_driver = {
> --
> 2.35.0
>
