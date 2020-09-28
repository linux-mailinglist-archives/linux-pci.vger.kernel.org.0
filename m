Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 101EC27B74A
	for <lists+linux-pci@lfdr.de>; Mon, 28 Sep 2020 23:44:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726901AbgI1VoC (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 28 Sep 2020 17:44:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726891AbgI1VoC (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 28 Sep 2020 17:44:02 -0400
Received: from mail-qv1-xf43.google.com (mail-qv1-xf43.google.com [IPv6:2607:f8b0:4864:20::f43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B071C061755
        for <linux-pci@vger.kernel.org>; Mon, 28 Sep 2020 14:44:02 -0700 (PDT)
Received: by mail-qv1-xf43.google.com with SMTP id q10so1291889qvs.1
        for <linux-pci@vger.kernel.org>; Mon, 28 Sep 2020 14:44:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=8fuD6KDogaQaBb3zkEarSXU9oLyjtCvWLZWd0pJwqO8=;
        b=R8qdGiDHnLhn3SVFCqt/XsTB/oOk7ZvxuTm7suVEPQ0b9ceYYxiJzTO7bHkic7vlHY
         52tCeaI24nxxvW8rWCyoE5IcHgvGKEZkTFbEVls9R1xWIgxYg7mJvLAmxuN4Wp5FS7ga
         AdrvAUWyl2tv03srDvT3KayJoM97PsjsKcCtSqY/BWL98c2YODhBbYUD0Tu2QYs7z+Ro
         2rloz2+HDF0ZpuHuwtW5Fo+rwXqtvN+CDW/gs2UUKSDCOuF9c+nwwl3eoG4HCEBcb4Hr
         0ROpCxfWxMFPEFOnnCU35C7WdkJxEwvYoDQi3gNOV69+SjLyvpOI4+hED/IbndEmGjGA
         oClw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=8fuD6KDogaQaBb3zkEarSXU9oLyjtCvWLZWd0pJwqO8=;
        b=PgumdILjIxxMQ6nrQC7mX7YFX6MTqDFtZCJK1f95DZydHxemUW6PFQpILZbSf6pZSL
         nO8LTfJUa/YNxeqXxZDMb1nUL4JvCkEbGTSCeFvZ4oqntt9asgDaJBbG2BTzzYxYWWJ5
         vM8fxGExhVU83Lfqw8Ekx81Bpa28T0+VRMAXovy36DZBHK00RNMBdyrAd698Tj1apci1
         JjcxxYZ0D1VOGxblPSTvlJvpn5hw9Z7WvIRuFg8wcdRD4wUnUedIoQgNY5OjtCfRwFEf
         zFZr2zKiFuJr5nJJhGIeuk24vxM7xULD9Kdm7YfM9IG0Kqsa+PJzRvUIC/cAHd96FrJ3
         UjJw==
X-Gm-Message-State: AOAM532l+DFKJAIFNpwTmYkMYVqpiVLLNk91ujFAFD91TvaGnVkoPguP
        Lsnw6lHRd5T9FBfRVIYhJrjHmTpwYzL60fAFrPU=
X-Google-Smtp-Source: ABdhPJzyWUga8l68FDJvWpG2r9K97axDL58K1sVm1cYnf6IUs2wXOfmN36FlD3iuYTzRRWn+n60jJm2DOiQfLGc4o5s=
X-Received: by 2002:a05:6214:292:: with SMTP id l18mr1666233qvv.3.1601329441534;
 Mon, 28 Sep 2020 14:44:01 -0700 (PDT)
MIME-Version: 1.0
References: <CAA85sZuexf2pqfHBCKKGRos8psg_6ZZFeXiFm3ncPz-6JtqEdQ@mail.gmail.com>
 <20200928170921.GA2485236@bjorn-Precision-5520> <CAA85sZuDVA1d_c7OQ3xyZiOVDneL6oN6bM-Sn2QfhfGAAoHhYg@mail.gmail.com>
 <CAKgT0UcQN77zrtRK8yKgNRR0pifGUceoRHXWW+cYukzmsQPNyQ@mail.gmail.com>
In-Reply-To: <CAKgT0UcQN77zrtRK8yKgNRR0pifGUceoRHXWW+cYukzmsQPNyQ@mail.gmail.com>
From:   Ian Kumlien <ian.kumlien@gmail.com>
Date:   Mon, 28 Sep 2020 23:43:50 +0200
Message-ID: <CAA85sZvEpUH_admrVOX0fX3Ug9erJqEwNRrBg1c72dPzTtFY5g@mail.gmail.com>
Subject: Re: [PATCH] Use maximum latency when determining L1/L0s ASPM v2
To:     Alexander Duyck <alexander.duyck@gmail.com>
Cc:     Bjorn Helgaas <helgaas@kernel.org>,
        linux-pci <linux-pci@vger.kernel.org>,
        "Saheed O. Bolarinwa" <refactormyself@gmail.com>,
        Puranjay Mohan <puranjay12@gmail.com>,
        Alexander Duyck <alexander.h.duyck@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Sep 28, 2020 at 9:53 PM Alexander Duyck
<alexander.duyck@gmail.com> wrote:
>
> On Mon, Sep 28, 2020 at 10:42 AM Ian Kumlien <ian.kumlien@gmail.com> wrot=
e:

> Just do a google search for "pcie gen 2 specification" you should find
> a few results that way.

Actually found a draft pcie gen 4 spec...

and according to 5.4.1.2.2 exit from the L1 State
"A Switch is required to initiate an L1 exit transition on its
Upstream Port Link after no more than 1
=CE=BCs from the beginning of an L1 exit transition on any of its
Downstream Port Links. Refer to
Section 4.2 for details of the Physical Layer signaling during L1 exit.

Consider the example in Figure 5-8. The numbers attached to each Port
represent the
corresponding Port=E2=80=99s reported Transmit Lanes L1 exit latency in uni=
ts
of microseconds.

Links 1, 2, and 3 are all in the L1 state, and Endpoint C initiates a
transition to the L0 state at time
T. Since Switch B takes 32 =CE=BCs to exit L1 on its Ports, Link 3 will
transition to the L0 state at T+32
(longest time considering T+8 for the Endpoint C, and T+32 for Switch B).

Switch B is required to initiate a transition from the L1 state on its
Upstream Port Link (Link 2)
after no more than 1 =CE=BCs from the beginning of the transition from the
L1 state on Link 3.
Therefore, transition to the L0 state will begin on Link 2 at T+1.
Similarly, Link 1 will start its
transition to the L0 state at time T+2.

Following along as above, Link 2 will complete its transition to the
L0 state at time T+33 (since
Switch B takes longer to transition and it started at time T+1). Link
1 will complete its transition to
the L0 state at time T+34 (since the Root Complex takes 32 =CE=BCs to
transition and it started at time
T+2).

Therefore, among Links 1, 2, and 3, the Link to complete the
transition to the L0 state last is Link 1
with a 34 =CE=BCs delay. This is the delay experienced by the packet that
initiated the transition in
Endpoint C."

So basically, my change to L1 is validated by this, ;)
