Return-Path: <linux-pci+bounces-13153-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 00706977AA0
	for <lists+linux-pci@lfdr.de>; Fri, 13 Sep 2024 10:06:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B4FF3289A5F
	for <lists+linux-pci@lfdr.de>; Fri, 13 Sep 2024 08:06:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 518531BD012;
	Fri, 13 Sep 2024 08:06:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bGvGZp99"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26B5D19F41A;
	Fri, 13 Sep 2024 08:06:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726214802; cv=none; b=gACHTFs6M4DDRHS/A3bJoVAoQdiIAfOjqdDeLIepS0TNrdoVqI88T0HJSVcy77wK0yqsXfDDCe+r3DIWfdA+WEeRTNNKlGH4AqBG9bG1SQ/c45o35iDW7Pp0zxthYTqvFTQtXxjthHkWGyiv05giaiW49MBXSlLw3FCK8o267TU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726214802; c=relaxed/simple;
	bh=MD2l9SNyu3ZBsypMQ+/IoqBO3U05pD4HilLDqHU29Co=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=a6n7t564UkEhvmLnQu9J7uPLUivDjq9XyJp+H3ziayFLPGxUcPPS0y9I+z7keImWPxDuG5pycAatQaZpkJOpf1NhMY6/MbsJ0Min1LFND4Z3PuIn+ifZz1smfJg/JN4ll2OM3u+LUDPHYqPeY+xsfvuw+mHHkUIPqGypEABCl5w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bGvGZp99; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CC520C4CEC6;
	Fri, 13 Sep 2024 08:06:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726214801;
	bh=MD2l9SNyu3ZBsypMQ+/IoqBO3U05pD4HilLDqHU29Co=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=bGvGZp99SbVtQpeHaM7zdcP57XEMMLY97hYIa0gJd9KxqkGK9e83aRzmj3bH53b/K
	 do6e8l1Xt26qdOow90ho6hqT8u+fy2dyZ5n0V2o/CFJ/3+Hm1HmnfkVyCdzEEzQuY0
	 psfVXPxVsSQ/HFg36bB9hnwOBhSLo3EBYsxuVZo6SzwBRlLNdm2lD5D8BXxIbF7htn
	 sRh7dkoEmXhCYJ66fFRZHeFn+GhBGbafhP5nNumGj7F494p9nXXzPWnPv8B/B5qpxR
	 xD1HbVOkgUMHflJAL4/SMtwfHuiP1mmD/nmgRxJgOWPy11alGmcQiQ7cebIovrGy5Z
	 XJUS1ADh8XZjg==
Received: by mail-lj1-f174.google.com with SMTP id 38308e7fff4ca-2f752d9ab62so7377331fa.3;
        Fri, 13 Sep 2024 01:06:41 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUvk+Wd/XflD8PbEyzyDIirAsSk1iKZAh35ytpLDUJM0v796zAnDUU+PzNTE07gq8kOXPZmBNB3@vger.kernel.org, AJvYcCV3IGuCba47dyoDzwtnn2xqmcc002ojEk42+hg1qAiVuEhMNWQlGOEU9WvxIRUeXYm8smDU3KS7r+rW@vger.kernel.org, AJvYcCWYyJtmVP+1HaBYyHJaEz5a5QUzqqBMKUUvaO5Edk9ZmJG6CHbYKhaR8/w2toZg+NU0H+zdO1Ac9qKBLlE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzF1Vh5i4b9Pa7VroQE0Lf1zLiFkFNZOQO5RGGUh9841jpw8WPx
	fAwq9IAgU0wdPZPhPEr8vLgQPqUGBTiN8FaEHOOqlepoNF+Xq9vpuYYW7bCq4YcUqEXniPM9wZ0
	fZnvzOF3A9ptohezZ7c6eQFrHY1c=
X-Google-Smtp-Source: AGHT+IE+ew2Mze9IQbmxClloe150YR5hrRkN14wPCpHG6zdeQ278SlShgZBB2SsagYMEaI/XbGylMVtilhQJI+JUBlg=
X-Received: by 2002:a05:6512:10d0:b0:536:5515:e9b5 with SMTP id
 2adb3069b0e04-5367ff3230fmr1083447e87.52.1726214800188; Fri, 13 Sep 2024
 01:06:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240613074258.4124603-1-zhanghongchen@loongson.cn>
 <a50b3865-8a04-4a9a-8d27-b317619a75c0@linux.intel.com> <7340a27e-67c1-c0c3-9304-77710dc44f7f@loongson.cn>
 <670927f1-42d8-40bc-bd79-55e178bd907a@linux.intel.com> <0052b62b-aafe-e2eb-6d66-4ad0178bdae1@loongson.cn>
 <db628499-6faf-43c8-93e5-c24208ca0578@linux.intel.com> <ea5a5c52-69ca-9504-dd80-a90c3000d9c6@loongson.cn>
In-Reply-To: <ea5a5c52-69ca-9504-dd80-a90c3000d9c6@loongson.cn>
From: Huacai Chen <chenhuacai@kernel.org>
Date: Fri, 13 Sep 2024 16:06:28 +0800
X-Gmail-Original-Message-ID: <CAAhV-H4KAnqCFDQ8Lg=9jBdQ3CNOLU8CKe8_7Px4VCmgKG_b5w@mail.gmail.com>
Message-ID: <CAAhV-H4KAnqCFDQ8Lg=9jBdQ3CNOLU8CKe8_7Px4VCmgKG_b5w@mail.gmail.com>
Subject: Re: [PATCH v3] PCI: pci_call_probe: call local_pci_probe() when
 selected cpu is offline
To: Hongchen Zhang <zhanghongchen@loongson.cn>
Cc: Ethan Zhao <haifeng.zhao@linux.intel.com>, Markus Elfring <Markus.Elfring@web.de>, 
	Bjorn Helgaas <bhelgaas@google.com>, Alex Belits <abelits@marvell.com>, 
	"Peter Zijlstra (Intel)" <peterz@infradead.org>, Nitesh Narayan Lal <nitesh@redhat.com>, 
	Frederic Weisbecker <frederic@kernel.org>, linux-pci@vger.kernel.org, 
	linux-kernel@vger.kernel.org, loongarch@lists.linux.dev, 
	stable@vger.kernel.org, Huacai Chen <chenhuacai@loongson.cn>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Ping?

On Wed, Jul 24, 2024 at 3:05=E2=80=AFPM Hongchen Zhang
<zhanghongchen@loongson.cn> wrote:
>
> On 2024/7/24 =E4=B8=8B=E5=8D=882:40, Ethan Zhao wrote:
> > On 7/24/2024 11:09 AM, Hongchen Zhang wrote:
> >> Hi Ethan,
> >>
> >> On 2024/7/24 =E4=B8=8A=E5=8D=8810:47, Ethan Zhao wrote:
> >>> On 7/24/2024 9:58 AM, Hongchen Zhang wrote:
> >>>> Hi Ethan,
> >>>> On 2024/7/22 PM 3:39, Ethan Zhao wrote:
> >>>>>
> >>>>> On 6/13/2024 3:42 PM, Hongchen Zhang wrote:
> >>>>>> Call work_on_cpu(cpu, fn, arg) in pci_call_probe() while the argum=
ent
> >>>>>> @cpu is a offline cpu would cause system stuck forever.
> >>>>>>
> >>>>>> This can be happen if a node is online while all its CPUs are
> >>>>>> offline (We can use "maxcpus=3D1" without "nr_cpus=3D1" to reprodu=
ce it).
> >>>>>>
> >>>>>> So, in the above case, let pci_call_probe() call local_pci_probe()
> >>>>>> instead of work_on_cpu() when the best selected cpu is offline.
> >>>>>>
> >>>>>> Fixes: 69a18b18699b ("PCI: Restrict probe functions to
> >>>>>> housekeeping CPUs")
> >>>>>> Cc: <stable@vger.kernel.org>
> >>>>>> Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>
> >>>>>> Signed-off-by: Hongchen Zhang <zhanghongchen@loongson.cn>
> >>>>>> ---
> >>>>>> v2 -> v3: Modify commit message according to Markus's suggestion
> >>>>>> v1 -> v2: Add a method to reproduce the problem
> >>>>>> ---
> >>>>>>   drivers/pci/pci-driver.c | 2 +-
> >>>>>>   1 file changed, 1 insertion(+), 1 deletion(-)
> >>>>>>
> >>>>>> diff --git a/drivers/pci/pci-driver.c b/drivers/pci/pci-driver.c
> >>>>>> index af2996d0d17f..32a99828e6a3 100644
> >>>>>> --- a/drivers/pci/pci-driver.c
> >>>>>> +++ b/drivers/pci/pci-driver.c
> >>>>>> @@ -386,7 +386,7 @@ static int pci_call_probe(struct pci_driver
> >>>>>> *drv, struct pci_dev *dev,
> >>>>>>           free_cpumask_var(wq_domain_mask);
> >>>>>>       }
> >>>>>> -    if (cpu < nr_cpu_ids)
> >>>>>
> >>>>> Why not choose the right cpu to callwork_on_cpu() ? the one that is
> >>>>> online. Thanks, Ethan
> >>>> Yes, let housekeeping_cpumask() return online cpu is a good idea,
> >>>> but it may be changed by command line. so the simplest way is to
> >>>> call local_pci_probe when the best selected cpu is offline.
> >>>
> >>> Hmm..... housekeeping_cpumask() should never return offline CPU, so
> >>> I guess you didn't hit issue with the CPU isolation, but the followin=
g
> >>> code seems not good.
> >> The issue is the dev node is online but the best selected cpu is
> >> offline, so it seems that there is no better way to directly set the
> >> cpu to nr_cpu_ids.
> >
> > I mean where the bug is ? you should debug more about that.
> > just add one cpu_online(cpu) check there might suggest there
> > is bug in the cpu selection stage.
> >
> >
> > if (node < 0 || node >=3D MAX_NUMNODES || !node_online(node) ||
> >          pci_physfn_is_probed(dev)) {
> >          cpu =3D nr_cpu_ids; // <----- if you hit here, then
> > local_pci_probe() should be called.
> >      } else {
> >          cpumask_var_t wq_domain_mask;
> >
> >          if (!zalloc_cpumask_var(&wq_domain_mask, GFP_KERNEL)) {
> >              error =3D -ENOMEM;
> >              goto out;
> >          }
> >          cpumask_and(wq_domain_mask,
> >                  housekeeping_cpumask(HK_TYPE_WQ),
> >                  housekeeping_cpumask(HK_TYPE_DOMAIN));
> >
> >          cpu =3D cpumask_any_and(cpumask_of_node(node),
> >                        wq_domain_mask);
> >          free_cpumask_var(wq_domain_mask);
> >                  // <----- if you hit here, then work_on_cpu(cpu,
> > local_pci_probe, &ddi) should be called.
> Yes, but if the offline cpu is selected, local_pci_probe should be called=
.
> >                  // do you mean there one offline cpu is selected ?
> Yes, the offline cpu is selected.
> >
> >      }
> >
> >      if (cpu < nr_cpu_ids)
> >          error =3D work_on_cpu(cpu, local_pci_probe, &ddi);
> >      else
> >          error =3D local_pci_probe(&ddi);
> >
> >
> > Thanks,
> > Ethan
> >
> >>>
> >>> ...
> >>>
> >>> if (node < 0 || node >=3D MAX_NUMNODES || !node_online(node) ||
> >>>          pci_physfn_is_probed(dev)) {
> >>>          cpu =3D nr_cpu_ids;
> >>>      } else {
> >>>
> >>> ....
> >>>
> >>> perhaps you could change the logic there and fix it  ?
> >>>
> >>> Thanks
> >>> Ethan
> >>>
> >>>
> >>>
> >>>>>
> >>>>>> +    if ((cpu < nr_cpu_ids) && cpu_online(cpu))
> >>>>>>           error =3D work_on_cpu(cpu, local_pci_probe, &ddi);
> >>>>>>       else
> >>>>>>           error =3D local_pci_probe(&ddi);
> >>>>
> >>>>
> >>
> >>
>
>
> --
> Best Regards
> Hongchen Zhang
>
>

