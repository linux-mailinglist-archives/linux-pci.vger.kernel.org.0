Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E7DE63170B7
	for <lists+linux-pci@lfdr.de>; Wed, 10 Feb 2021 20:55:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232578AbhBJTzX (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 10 Feb 2021 14:55:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232045AbhBJTzV (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 10 Feb 2021 14:55:21 -0500
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FE9BC061574
        for <linux-pci@vger.kernel.org>; Wed, 10 Feb 2021 11:54:41 -0800 (PST)
Received: by mail-ej1-x631.google.com with SMTP id y9so6273492ejp.10
        for <linux-pci@vger.kernel.org>; Wed, 10 Feb 2021 11:54:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=r8ql4t5FN+DQ5z6SKaawhVvoEWWehqT+I1El6GCGVQ4=;
        b=UZb6WVbTWSGdh6Bv8sJ0CZE9rE5T4V6FvNnZjV+yO5TAkRphM7kzZ4CnBzE+DtGp7T
         KZ8+plW5edXC0gs6ASCzCyGGBR3vCrnphh8APG2ELadQqqAiM6B+WMcvnSehEoq6sNnR
         J0nHzUDbHdZRZcZYKFCy1GsHkZMhkqgChpVYtn/C9TaUk4wW/raUMMFvoMwLNKNjY53p
         tB8hJhtHR/KBTboYiE5NKWek/XIXfGesldItsTvDTnGbmz5y37Km1pbFiJzGF+Bm1P+E
         BzZCe/NLem1n16h0IqP8PtixD6bbV9Z+ODchWMMICWSnZG844Zm9P0nm/K/1rPyxZkA9
         kwHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=r8ql4t5FN+DQ5z6SKaawhVvoEWWehqT+I1El6GCGVQ4=;
        b=e4dFoDptZMERyzaeYcEBJC3/1DvTzb6/Ke0eIviqS60JroFuBG/lZ1yqV0IXydvxr5
         lgbkuICpH3bYguePzaUqRrrQbOjn9RJFCSuoQx2MDp1ISRaEIK/fMXKAH8lIcNgbF1Lb
         0g7GdNSAMe9Xxc7IRzjnCP+QGd/LmRc4KdhzhObhZlnSr8nqEnZV8Jqc6iDOfODSnPEs
         zljCoL5HY7LGiZ4ICqAmEvIUvW3GidQdUr4r2vk4ejwQGn1+pPfOGMeWSizlNUacIz89
         Z8zwRzAni8FQ53ZZuGJWm3gxuAmqRwDTvIGACm8NAnvgmNL3vIipP0AQ8qd5roq/QmqA
         EnxA==
X-Gm-Message-State: AOAM530VW9zpR9h9soSSVPZZM0IIcsgAIRZVlqYiEcHzgJu09vLmJOXk
        MT0zyjnqS1o55pgddqNG926Ji12oJmtRlp1ikRrtdQ==
X-Google-Smtp-Source: ABdhPJyFlWbTp88uiBk8oj2jnks2vvVMZHRU5zQHaleujzXDGp2pVOAsUaO9gD/k4yZ6I0HiskQDvayp/pdzxo6NaBc=
X-Received: by 2002:a17:906:57cd:: with SMTP id u13mr4661147ejr.341.1612986880263;
 Wed, 10 Feb 2021 11:54:40 -0800 (PST)
MIME-Version: 1.0
References: <20210210000259.635748-1-ben.widawsky@intel.com>
 <20210210000259.635748-3-ben.widawsky@intel.com> <20210210174104.0000710a@Huawei.com>
 <20210210185319.chharluce2ly4cne@intel.com>
In-Reply-To: <20210210185319.chharluce2ly4cne@intel.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Wed, 10 Feb 2021 11:54:29 -0800
Message-ID: <CAPcyv4i4_6HLNpw7p-1PD9cePuMuPkvUfx0ROT8M0Y7ftxzYfg@mail.gmail.com>
Subject: Re: [PATCH v2 2/8] cxl/mem: Find device capabilities
To:     Ben Widawsky <ben.widawsky@intel.com>
Cc:     Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        linux-cxl@vger.kernel.org, Linux ACPI <linux-acpi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-nvdimm <linux-nvdimm@lists.01.org>,
        Linux PCI <linux-pci@vger.kernel.org>,
        Bjorn Helgaas <helgaas@kernel.org>,
        Chris Browy <cbrowy@avery-design.com>,
        Christoph Hellwig <hch@infradead.org>,
        David Hildenbrand <david@redhat.com>,
        David Rientjes <rientjes@google.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Jon Masters <jcm@jonmasters.org>,
        Rafael Wysocki <rafael.j.wysocki@intel.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Vishal Verma <vishal.l.verma@intel.com>,
        "John Groves (jgroves)" <jgroves@micron.com>,
        "Kelley, Sean V" <sean.v.kelley@intel.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Feb 10, 2021 at 10:53 AM Ben Widawsky <ben.widawsky@intel.com> wrote:
[..]
> > Christoph raised this in v1, and I agree with him that his would me more compact
> > and readable as
> >
> >       struct range pmem_range;
> >       struct range ram_range;
> >
> > The discussion seemed to get lost without getting resolved that I can see.
> >
>
> I had been waiting for Dan to chime in, since he authored it. I'll change it and
> he can yell if he cares.

No concerns from me.

>
> > > +
> > > +   struct {
> > > +           struct range range;
> > > +   } ram;
> >
> > > +};
> > > +
> > > +#endif /* __CXL_H__ */
> > > diff --git a/drivers/cxl/mem.c b/drivers/cxl/mem.c
> > > index 99a6571508df..0a868a15badc 100644
> > > --- a/drivers/cxl/mem.c
> > > +++ b/drivers/cxl/mem.c
> >
> >
> > ...
> >
> > > +static void cxl_mem_mbox_timeout(struct cxl_mem *cxlm,
> > > +                            struct mbox_cmd *mbox_cmd)
> > > +{
> > > +   struct device *dev = &cxlm->pdev->dev;
> > > +
> > > +   dev_dbg(dev, "Mailbox command (opcode: %#x size: %zub) timed out\n",
> > > +           mbox_cmd->opcode, mbox_cmd->size_in);
> > > +
> > > +   if (IS_ENABLED(CONFIG_CXL_MEM_INSECURE_DEBUG)) {
> >
> > Hmm.  Whilst I can see the advantage of this for debug, I'm not sure we want
> > it upstream even under a rather evil looking CONFIG variable.
> >
> > Is there a bigger lock we can use to avoid chance of accidental enablement?
>
> Any suggestions? I'm told this functionality was extremely valuable for NVDIMM,
> though I haven't personally experienced it.

Yeah, there was no problem with the identical mechanism in LIBNVDIMM
land. However, I notice that the useful feature for LIBNVDIMM is the
option to dump all payloads. This one only fires on timeouts which is
less useful. So I'd say fix it to dump all payloads on the argument
that the safety mechanism was proven with the LIBNVDIMM precedent, or
delete it altogether to maintain v5.12 momentum. Payload dumping can
be added later.

[..]
> > > diff --git a/include/uapi/linux/pci_regs.h b/include/uapi/linux/pci_regs.h
> > > index e709ae8235e7..6267ca9ae683 100644
> > > --- a/include/uapi/linux/pci_regs.h
> > > +++ b/include/uapi/linux/pci_regs.h
> > > @@ -1080,6 +1080,7 @@
> > >
> > >  /* Designated Vendor-Specific (DVSEC, PCI_EXT_CAP_ID_DVSEC) */
> > >  #define PCI_DVSEC_HEADER1          0x4 /* Designated Vendor-Specific Header1 */
> > > +#define PCI_DVSEC_HEADER1_LENGTH_MASK      0xFFF00000
> >
> > Seems sensible to add the revision mask as well.
> > The vendor id currently read using a word read rather than dword, but perhaps
> > neater to add that as well for completeness?
> >
> > Having said that, given Bjorn's comment on clashes and the fact he'd rather see
> > this stuff defined in drivers and combined later (see review patch 1 and follow
> > the link) perhaps this series should not touch this header at all.
>
> I'm fine to move it back.

Yeah, we're playing tennis now between Bjorn's and Christoph's
comments, but I like Bjorn's suggestion of "deduplicate post merge"
given the bloom of DVSEC infrastructure landing at the same time.
