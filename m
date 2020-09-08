Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C58B126187D
	for <lists+linux-pci@lfdr.de>; Tue,  8 Sep 2020 19:56:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731358AbgIHR4m (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 8 Sep 2020 13:56:42 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:37441 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731657AbgIHR4Y (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 8 Sep 2020 13:56:24 -0400
Received: by mail-pf1-f194.google.com with SMTP id w7so11609884pfi.4;
        Tue, 08 Sep 2020 10:56:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=gOMveLN5kBZQwgZihKiozgHiSqkU32Nr37Ef5vnEGOk=;
        b=nQxWg5SJcJOScSPUhzRX76KEhfL4sWEcG3pR49XK9gJLz24m6YyI6fwn3BPmHMxjrR
         lwBNmCiDY61dahG+BFXolH0SiT0Y/6SesG+JsKPlMBN4gnVbpurR6R65EYd/Fyppak3x
         qNPFmSvXuk7/N2g4yQTeayVap+YJM0DtwH4PqRyEUU1gl/S3own2GJxwP6nwgjPe91sQ
         km9RgpDbH9fjCmNtyngYdKqt8F19b9Ovc54Y7gG+M515nSY21vPcWvGWVwgMcA6WEh9B
         /ljoHp8QtTGye9lkuoXlAWOWS9uwOF5462bwHZH6jqzooHBrNoarOc3K4gfOuLZewzKg
         6jtg==
X-Gm-Message-State: AOAM533KQmr5O5nVCmD/Oq81D/IWz8KGm/h1f++fg8h9dpcqlvvJDbzJ
        ysUqDViqPm/lyenlbo7VSj+gvPGMkMo=
X-Google-Smtp-Source: ABdhPJy/aF6YE7urCDjOKNmzg89DjNVDoGD6VdvuIbjSABrCTTI0dsRRODq+hwOUMukQ9qPXEYOlLA==
X-Received: by 2002:aa7:80d3:: with SMTP id a19mr25957573pfn.102.1599587783555;
        Tue, 08 Sep 2020 10:56:23 -0700 (PDT)
Received: from ?IPv6:2601:647:4000:d7:fb09:e536:da63:a7cd? ([2601:647:4000:d7:fb09:e536:da63:a7cd])
        by smtp.gmail.com with ESMTPSA id m188sm90193pfd.56.2020.09.08.10.56.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 08 Sep 2020 10:56:22 -0700 (PDT)
Subject: Re: [PATCH] Revert "block: revert back to synchronous request_queue
 removal"
To:     Ethan Zhao <haifeng.zhao@intel.com>, axboe@kernel.dk,
        bhelgaas@google.com
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org, mcgrof@kernel.org,
        ShanshanX.Zhang@intel.com, pei.p.jia@intel.com
References: <20200908075047.5140-1-haifeng.zhao@intel.com>
From:   Bart Van Assche <bvanassche@acm.org>
Autocrypt: addr=bvanassche@acm.org; prefer-encrypt=mutual; keydata=
 mQENBFSOu4oBCADcRWxVUvkkvRmmwTwIjIJvZOu6wNm+dz5AF4z0FHW2KNZL3oheO3P8UZWr
 LQOrCfRcK8e/sIs2Y2D3Lg/SL7qqbMehGEYcJptu6mKkywBfoYbtBkVoJ/jQsi2H0vBiiCOy
 fmxMHIPcYxaJdXxrOG2UO4B60Y/BzE6OrPDT44w4cZA9DH5xialliWU447Bts8TJNa3lZKS1
 AvW1ZklbvJfAJJAwzDih35LxU2fcWbmhPa7EO2DCv/LM1B10GBB/oQB5kvlq4aA2PSIWkqz4
 3SI5kCPSsygD6wKnbRsvNn2mIACva6VHdm62A7xel5dJRfpQjXj2snd1F/YNoNc66UUTABEB
 AAG0JEJhcnQgVmFuIEFzc2NoZSA8YnZhbmFzc2NoZUBhY20ub3JnPokBOQQTAQIAIwUCVI67
 igIbAwcLCQgHAwIBBhUIAgkKCwQWAgMBAh4BAheAAAoJEHFcPTXFzhAJ8QkH/1AdXblKL65M
 Y1Zk1bYKnkAb4a98LxCPm/pJBilvci6boefwlBDZ2NZuuYWYgyrehMB5H+q+Kq4P0IBbTqTa
 jTPAANn62A6jwJ0FnCn6YaM9TZQjM1F7LoDX3v+oAkaoXuq0dQ4hnxQNu792bi6QyVdZUvKc
 macVFVgfK9n04mL7RzjO3f+X4midKt/s+G+IPr4DGlrq+WH27eDbpUR3aYRk8EgbgGKvQFdD
 CEBFJi+5ZKOArmJVBSk21RHDpqyz6Vit3rjep7c1SN8s7NhVi9cjkKmMDM7KYhXkWc10lKx2
 RTkFI30rkDm4U+JpdAd2+tP3tjGf9AyGGinpzE2XY1K5AQ0EVI67igEIAKiSyd0nECrgz+H5
 PcFDGYQpGDMTl8MOPCKw/F3diXPuj2eql4xSbAdbUCJzk2ETif5s3twT2ER8cUTEVOaCEUY3
 eOiaFgQ+nGLx4BXqqGewikPJCe+UBjFnH1m2/IFn4T9jPZkV8xlkKmDUqMK5EV9n3eQLkn5g
 lco+FepTtmbkSCCjd91EfThVbNYpVQ5ZjdBCXN66CKyJDMJ85HVr5rmXG/nqriTh6cv1l1Js
 T7AFvvPjUPknS6d+BETMhTkbGzoyS+sywEsQAgA+BMCxBH4LvUmHYhpS+W6CiZ3ZMxjO8Hgc
 ++w1mLeRUvda3i4/U8wDT3SWuHcB3DWlcppECLkAEQEAAYkBHwQYAQIACQUCVI67igIbDAAK
 CRBxXD01xc4QCZ4dB/0QrnEasxjM0PGeXK5hcZMT9Eo998alUfn5XU0RQDYdwp6/kMEXMdmT
 oH0F0xB3SQ8WVSXA9rrc4EBvZruWQ+5/zjVrhhfUAx12CzL4oQ9Ro2k45daYaonKTANYG22y
 //x8dLe2Fv1By4SKGhmzwH87uXxbTJAUxiWIi1np0z3/RDnoVyfmfbbL1DY7zf2hYXLLzsJR
 mSsED/1nlJ9Oq5fALdNEPgDyPUerqHxcmIub+pF0AzJoYHK5punqpqfGmqPbjxrJLPJfHVKy
 goMj5DlBMoYqEgpbwdUYkH6QdizJJCur4icy8GUNbisFYABeoJ91pnD4IGei3MTdvINSZI5e
Message-ID: <be547312-c89d-57bf-edec-1e67d3604665@acm.org>
Date:   Tue, 8 Sep 2020 10:56:21 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20200908075047.5140-1-haifeng.zhao@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 2020-09-08 00:50, Ethan Zhao wrote:
> From: Ethan Zhao <Haifeng.Zhao@intel.com>
> 
> 'commit e8c7d14ac6c3 ("block: revert back to synchronous request_queue
> removal")' introduced panic issue to NVMe hotplug as following(hit
> after just 2 times NVMe SSD hotplug under stable 5.9-RC2):

Please fix this in the NVMe driver instead of reverting commit e8c7d14ac6c3.

Thanks,

Bart.
