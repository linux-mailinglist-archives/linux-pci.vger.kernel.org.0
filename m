Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 80E9A4A66D2
	for <lists+linux-pci@lfdr.de>; Tue,  1 Feb 2022 22:09:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233148AbiBAVJt (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 1 Feb 2022 16:09:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232017AbiBAVJt (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 1 Feb 2022 16:09:49 -0500
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92E29C06173B
        for <linux-pci@vger.kernel.org>; Tue,  1 Feb 2022 13:09:49 -0800 (PST)
Received: by mail-pj1-x102a.google.com with SMTP id cq9-20020a17090af98900b001b8262fe2d5so642143pjb.0
        for <linux-pci@vger.kernel.org>; Tue, 01 Feb 2022 13:09:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ZfkXO1SmtkeMFUVSjvOQaqvQ+wHw5M7LGlS5Mzh9l6g=;
        b=kWlOYQrzrIg8Ucw66RplSgM6whdDw/Mz1z9iyt2dyGE/KJXUWZDi3iBQ1IKXcKGPLY
         qDKcWPSDgTz5z3XE+FiQrtW2QAJ4BArh/UzDO2LmvBgjGsi+VMnYRdL95Pwb4vJs5GVw
         8daSdqYv0u1sIlX/T5AnKtMxNycMy+zjC811VFW1JyNoHZHHmkkl7rz1Txv409pblJBA
         H96vayr1EQSaBvShBIt88oWYMT3aEx79xcQYxceVba7ss6eFNX0pNKe/wQnwJonv+8w1
         +v5yBpXqeQlg9FzQdbfniUiFnbCw17LVQUK6pA6ktJGWv5n4RKaB/aN/KrtR7WAYSVLn
         uePg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ZfkXO1SmtkeMFUVSjvOQaqvQ+wHw5M7LGlS5Mzh9l6g=;
        b=7L9o6WGDfV7edHuxT+uPK3scT4jvb4eadw/+xlP6S2A2kL9ykoaZ2xdSNqmZliQPtX
         wEDl+Lb8KyddJG6kNts8Nw2rR79oR6SmQwQTZMB9fD65LUvC3q47eLYnED6khWRTPZo9
         bWTpotlq1vlM8i2wRs0+RNW8PWJkd46xsX5HUzU0TKJcO2//mRb+FDwcUbCusdNruxcM
         ml2Lb113BPVTPfclc9l7XKWp+5nqJLWvNhm7HohXmZnttuJtpzoLlU5WRoRyp88grL5m
         ZzWVFg463cfK+ckvYrC1Fy+A8ZhxTQr65dQYeNUjTAazQXq5SLsvfUMjGNBQMnwHdPyb
         YOmw==
X-Gm-Message-State: AOAM530VVuFfyi2edoOQi1eGy6OoTWvdUxJAobmfqpv8CFdJ/0XH1ZG4
        Z74i647/ZwWeJextPBQHTpT1J7RwVu2jzLd8nYfOJOPnu40=
X-Google-Smtp-Source: ABdhPJwxrhpjOmKbpFy9646jr5PcqrEbt3VRXObtW3+qrnpZHuE5dGOHs+xgCzm77qFq0pYWb0bEuGnXcbI9Bwr8vAk=
X-Received: by 2002:a17:90b:3ece:: with SMTP id rm14mr226745pjb.220.1643749788965;
 Tue, 01 Feb 2022 13:09:48 -0800 (PST)
MIME-Version: 1.0
References: <164298411792.3018233.7493009997525360044.stgit@dwillia2-desk3.amr.corp.intel.com>
 <164298425201.3018233.647136583483232467.stgit@dwillia2-desk3.amr.corp.intel.com>
 <20220201151728.zgc55ckks672gedz@intel.com>
In-Reply-To: <20220201151728.zgc55ckks672gedz@intel.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Tue, 1 Feb 2022 13:09:42 -0800
Message-ID: <CAPcyv4hQ2BFWT7D45UYaL0JfTuSfpaAWbKdqLYsrbRYifre7HA@mail.gmail.com>
Subject: Re: [PATCH v3 25/40] cxl/core/port: Remove @host argument for dport +
 decoder enumeration
To:     Ben Widawsky <ben.widawsky@intel.com>
Cc:     linux-cxl@vger.kernel.org, Linux PCI <linux-pci@vger.kernel.org>,
        Linux NVDIMM <nvdimm@lists.linux.dev>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Feb 1, 2022 at 7:17 AM Ben Widawsky <ben.widawsky@intel.com> wrote:
>
> On 22-01-23 16:30:52, Dan Williams wrote:
> > Now that dport and decoder enumeration is centralized in the port
> > driver, the @host argument for these helpers can be made implicit. For
> > the root port the host is the port's uport device (ACPI0017 for
> > cxl_acpi), and for all other descendant ports the devm context is the
> > parent of @port.
> >
> > Signed-off-by: Dan Williams <dan.j.williams@intel.com>
>
> I really like removing @host as much as possible everywhere.

It's only possible where the parent device is the host.

> Reviewed-by: Ben Widawsky <ben.widawsky@intel.com>
