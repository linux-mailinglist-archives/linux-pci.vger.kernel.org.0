Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AC15D320686
	for <lists+linux-pci@lfdr.de>; Sat, 20 Feb 2021 18:51:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229784AbhBTRtN (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 20 Feb 2021 12:49:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229876AbhBTRtM (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 20 Feb 2021 12:49:12 -0500
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CA0EC06178C
        for <linux-pci@vger.kernel.org>; Sat, 20 Feb 2021 09:48:31 -0800 (PST)
Received: by mail-ej1-x629.google.com with SMTP id do6so22008575ejc.3
        for <linux-pci@vger.kernel.org>; Sat, 20 Feb 2021 09:48:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=niF1k3dVyqWcVFhX7Jys8F/FWOuqyr/3JpoSyGWUad4=;
        b=SJiJGOm92EOLuEmD8ZxINHCPgWL9FHxOSQ3VIYWX9zoyH2E9wOjXIS9rFt4qflATpv
         hSN/bjk3gMWmOoic96yidZvVl7/B4XMCsqfh0PkuMvTvPzxsbnnAAzqFwvJBX/EHx6Jq
         lEXEZ04J4mAMFF3qpTPsBe+t1d1hZCpoZ1tHexVfyV6BEj3IJZ6FxOnS5w7SFjV4xaQB
         bzdJovpxJgMpQMBdOPWU4kOe8uTftngZHfL80X3V4NBKw6dQvwl3+V0eAaAFtkaj7Nyw
         q6pWkVkKDyqb9Tw8d5bxJN+VZ9kPSu7gfMjLM+uXAWL9W050qu1qq3zAwkiaymsFO0Qm
         BLwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=niF1k3dVyqWcVFhX7Jys8F/FWOuqyr/3JpoSyGWUad4=;
        b=NB0lzNcXKbTlnvKN2CDNr0OGTZYZTZJkPkRZhUaTRvudyqza8v/1GJCBxjJYpnKpUm
         u+Fklqz4d6KbugLzDDdoS/+XsbcCgk5NRt3Pzne9VM19gT7oUTx5u3BwLNO/4XkGggeo
         xtNvR8Jyca+vZunrDRpq04kQFccWup8r+7K3GMUaEFtBDycBgnD4z5m0DaLF2urpDZva
         hXQ6+8x+lminT14rlKoXXHExdX5VcX98GqDOWz5LBEYh+tGxezDsYF4F7a4BkFO4VsxZ
         lG6V1jIp2H+z8WyTVpFU2bzJU+eElfOMq0YEgCRgYV1dvlkhv9lmhxJisuc2G0km88XW
         BMVg==
X-Gm-Message-State: AOAM532IWalp/vu9axCJH7cv7ARzt5qjLO/T5N+fzxx7Es+29Wle3TCn
        DjmvKO++ksnKgtx5O1HlBwhHRHPJDq0Zfg8DuYTswg==
X-Google-Smtp-Source: ABdhPJzMFtM3V/tSlVTUOFi/gy4tLf3ErLDeRmJYFtXE81s7f90uq338SYuA8goZna9AO+QqkY89+APsjw6TJdTe694=
X-Received: by 2002:a17:907:373:: with SMTP id rs19mr1248541ejb.341.1613843310167;
 Sat, 20 Feb 2021 09:48:30 -0800 (PST)
MIME-Version: 1.0
References: <20210217040958.1354670-1-ben.widawsky@intel.com>
 <20210217040958.1354670-5-ben.widawsky@intel.com> <YDBkOB3K8UqVakFf@Konrads-MacBook-Pro.local>
 <20210220163344.csczmkyxkpu4fxah@intel.com>
In-Reply-To: <20210220163344.csczmkyxkpu4fxah@intel.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Sat, 20 Feb 2021 09:48:22 -0800
Message-ID: <CAPcyv4jWnW_i=jaGP_nXRuGgwmngObw_V8AOPY3k_YMHkL-8Eg@mail.gmail.com>
Subject: Re: [PATCH v5 4/9] cxl/mem: Add basic IOCTL interface
To:     Ben Widawsky <ben.widawsky@intel.com>
Cc:     Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
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
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Rafael Wysocki <rafael.j.wysocki@intel.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Vishal Verma <vishal.l.verma@intel.com>,
        "John Groves (jgroves)" <jgroves@micron.com>,
        "Kelley, Sean V" <sean.v.kelley@intel.com>,
        kernel test robot <lkp@intel.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Al Viro <viro@zeniv.linux.org.uk>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Sat, Feb 20, 2021 at 8:33 AM Ben Widawsky <ben.widawsky@intel.com> wrote:
>
> On 21-02-19 20:22:00, Konrad Rzeszutek Wilk wrote:
> > ..snip..
> > > +static int handle_mailbox_cmd_from_user(struct cxl_mem *cxlm,
> > > +                                   const struct cxl_mem_command *cmd,
> > > +                                   u64 in_payload, u64 out_payload,
> > > +                                   s32 *size_out, u32 *retval)
> > > +{
> > > +   struct device *dev = &cxlm->pdev->dev;
> > > +   struct mbox_cmd mbox_cmd = {
> > > +           .opcode = cmd->opcode,
> > > +           .size_in = cmd->info.size_in,
> > > +           .size_out = cmd->info.size_out,
> > > +   };
> > > +   int rc;
> > > +
> > > +   if (cmd->info.size_out) {
> > > +           mbox_cmd.payload_out = kvzalloc(cmd->info.size_out, GFP_KERNEL);
> > > +           if (!mbox_cmd.payload_out)
> > > +                   return -ENOMEM;
> > > +   }
> > > +
> > > +   if (cmd->info.size_in) {
> > > +           mbox_cmd.payload_in = vmemdup_user(u64_to_user_ptr(in_payload),
> > > +                                              cmd->info.size_in);
> > > +           if (IS_ERR(mbox_cmd.payload_in))
> > > +                   return PTR_ERR(mbox_cmd.payload_in);
> >
> > Not that this should happen, but what if info.size_out was set? Should
> > you also free mbox_cmd.payload_out?
> >
>
> Thanks Konrad.
>
> Dan, do you want me to send a fixup patch? This bug was introduced from v4->v5.

Yes, please, incremental to libnvdimm-for-next which I'm planning to
send to Linus on Tuesday.
