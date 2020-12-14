Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 831CA2D9F54
	for <lists+linux-pci@lfdr.de>; Mon, 14 Dec 2020 19:40:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2408891AbgLNSi7 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 14 Dec 2020 13:38:59 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:33725 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2408895AbgLNSix (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 14 Dec 2020 13:38:53 -0500
Received: from mail-ej1-f69.google.com ([209.85.218.69])
        by youngberry.canonical.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <guilherme.piccoli@canonical.com>)
        id 1kosjb-0008II-NP
        for linux-pci@vger.kernel.org; Mon, 14 Dec 2020 18:38:11 +0000
Received: by mail-ej1-f69.google.com with SMTP id dc13so4870463ejb.9
        for <linux-pci@vger.kernel.org>; Mon, 14 Dec 2020 10:38:11 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Ck0oP8pI3gg0GT2KFOZPFk92OV6dXAXwEcwui0viHso=;
        b=OAdP4oPdjrWG42u4Q+fZxRVFcYydE5zALLJULLLNPVXutmV96MEM1kWsy0mwlcyMfb
         JLJSmmTypC9rTIHuHnUpmHirhc8tan4z16xSXL4ySMxKHgBb78AZyNBgwUdwFIc+Tik7
         s4ExNW3h5Zj6VLQ3Ii80yaeRQX3M2nlVbHFYFYymdGNm7v21uvbqKIh1baFZltXSdXlq
         8f4zJI7fHDg3eM64nxmDvrpWfnjwuuTlwqqqfSi/B6qx3VauByKKRtF/2qMVrg5kZSDa
         hEzPI7QxsBmEu6zmaeehMMSyUi4gD4JMsiq7hznx4JDhpXc9RHmoIaTEFlcJJ9WpZkiB
         8mnA==
X-Gm-Message-State: AOAM530lcc0nV81m+UCQetDINdxU8735SpIDgvlHbrheXfhfNR/B51ge
        bXEECerXbPhz7LCUZnO07TBYCyWvQP/B8tGWmW7W8sy+hyy1IQIBBtsqfRZGoHWB03D/j8aQfTk
        cThGAGI/KKX1VYzk0d0mXqS3z236S+tKutCsYXIJKrJ1OhC1hjnB6AQ==
X-Received: by 2002:a17:906:52da:: with SMTP id w26mr24039100ejn.347.1607971091416;
        Mon, 14 Dec 2020 10:38:11 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyElQP/X5d9T8985RSfW1cNFOkiscTnxl7jAd7FT4HeYlxPMDKWbJXdNibsjCLmGkepQdsHIXSO9kYrvDhrJEc=
X-Received: by 2002:a17:906:52da:: with SMTP id w26mr24039078ejn.347.1607971091260;
 Mon, 14 Dec 2020 10:38:11 -0800 (PST)
MIME-Version: 1.0
References: <c4bf0e02cd7d4ec49462245a315f882f@ess.eu>
In-Reply-To: <c4bf0e02cd7d4ec49462245a315f882f@ess.eu>
From:   Guilherme Piccoli <gpiccoli@canonical.com>
Date:   Mon, 14 Dec 2020 15:37:35 -0300
Message-ID: <CAHD1Q_wQaZOhr6orDP1EE7MuORpbRcUGCmnb4pvL3676BTGpwQ@mail.gmail.com>
Subject: Re: Kernel oops while using AER inject
To:     Hinko Kocevar <Hinko.Kocevar@ess.eu>
Cc:     "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

I see you're running a 3.10 modified kernel (Red Hat / CentOS ?) -
suggest you to try the upstream kernel, if possible. If the error
persists in the mainline kernel, it's likely you can get more support
here!

Cheers,


Guilherme
