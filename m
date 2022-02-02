Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 15C794A7724
	for <lists+linux-pci@lfdr.de>; Wed,  2 Feb 2022 18:55:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236690AbiBBRzI (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 2 Feb 2022 12:55:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236254AbiBBRzH (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 2 Feb 2022 12:55:07 -0500
Received: from mail-ot1-x32d.google.com (mail-ot1-x32d.google.com [IPv6:2607:f8b0:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2EB9C061714;
        Wed,  2 Feb 2022 09:55:07 -0800 (PST)
Received: by mail-ot1-x32d.google.com with SMTP id q14-20020a05683022ce00b005a6162a1620so222990otc.0;
        Wed, 02 Feb 2022 09:55:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=ZS+k85G5qylVBfk3NCCSnd5a87KERoi5Cnaumfe0BkI=;
        b=f+LHESUPOX2rqn4gSzIxZmkexATu9B0sRe3y9Io+ncuxKnDIW7GV/Fc8ZtblvOukaE
         uMiJ5c07J9kHeBwMlha08KCr11hQP2240dBo52Cjewr7GBJpyFJlr6k3PZqwDzENF4Qs
         grLW11oh2TwxyzMorXJ+5qUPTOUtMab/D/BG8Dbm94QRMZYVOLE5rO/Qb0Yg6CngxXyX
         5Kv/ABXh95WsVI/fGgKD1MONF/7QuM+bSWk10FIbBNzKSX9m+XQ0GVmpCbhfQjjTLQOo
         /grVsjKFVEzVOFvKrWnjYQPevROOo5UfqMRcTN9eQ5D5gYwvQqcIrmMD0G97x9I53brV
         BMSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=ZS+k85G5qylVBfk3NCCSnd5a87KERoi5Cnaumfe0BkI=;
        b=eCJ9NU112x2/hiYVpQRSmwppg/6AoeEP5pucOY9vL3OBj4UCMSQJ/+xLwVsTF/Kgro
         UKRlz7w+Rb/LPI1KuN1XislzDAc8QoE2zbBd+CF5ekOc900swzI7HfbKxHMYgpYocJqp
         0W5BIEkVJSvBwCuNKm7JmoU8P8RbkZNhaWQYeONHax7xVsr1Hp338XGhq2vEeohVCXFY
         lC1fWLKtvnYmIId0tT74yDpMwPlzyzRfvqP3By49RjLdWjJJJVTP8HZ4AKzyp+w+RZJu
         J5gkw5SK5bNpjomTQNgJQcfjU+VIZ2B4VsQyJ3HjCzYG52K468CrWgKy/B5UmxRx1/TJ
         oi2w==
X-Gm-Message-State: AOAM533uEOk054sNJkRcz8Z5PavSSFywEpcVldMffVSpjxNKfYbSy/DT
        bDeMBiZ3ahYF7Z1B3Tkftww=
X-Google-Smtp-Source: ABdhPJyzlv68GqTOOlCLUqk4ZnqV5AEHsig9CTW8cmKhdlDHkx/MBJLvFlyQjrsbAAKC/c8xQonpgw==
X-Received: by 2002:a9d:112:: with SMTP id 18mr17603653otu.379.1643824507123;
        Wed, 02 Feb 2022 09:55:07 -0800 (PST)
Received: from ?IPV6:2603:8081:2802:9dfb:3cb0:d8d2:94fa:3630? (2603-8081-2802-9dfb-3cb0-d8d2-94fa-3630.res6.spectrum.com. [2603:8081:2802:9dfb:3cb0:d8d2:94fa:3630])
        by smtp.gmail.com with ESMTPSA id bl6sm6288403oib.38.2022.02.02.09.55.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 02 Feb 2022 09:55:06 -0800 (PST)
Message-ID: <6a565605-ff32-6079-9430-bceb428c3889@gmail.com>
Date:   Wed, 2 Feb 2022 11:54:57 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.2
Subject: Re: [RFC PATCH 2/3] Add PCIe enclosure management auxiliary driver
Content-Language: en-US
To:     Mariusz Tkaczyk <mariusz.tkaczyk@linux.intel.com>
Cc:     Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        Dan Williams <dan.j.williams@intel.com>,
        Keith Busch <kbusch@kernel.org>, kw@linux.com,
        helgaas@kernel.org, lukas@wunner.de, pavel@ucw.cz,
        linux-cxl@vger.kernel.org, martin.petersen@oracle.com,
        James.Bottomley@hansenpartnership.com,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
References: <cover.1642460765.git.stuart.w.hayes@gmail.com>
 <111e1684ab4a77c7ca4abc9f7fd1f37f9534d937.1642460765.git.stuart.w.hayes@gmail.com>
 <20220131125915.0000294f@linux.intel.com>
From:   stuart hayes <stuart.w.hayes@gmail.com>
In-Reply-To: <20220131125915.0000294f@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



On 1/31/2022 5:59 AM, Mariusz Tkaczyk wrote:
> Hi Stuart,
> On Mon, 17 Jan 2022 22:17:57 -0600
> Stuart Hayes <stuart.w.hayes@gmail.com> wrote:
> 
>> +	switch (output->status) {
>> +	case 0:
>> +		break;
>> +	case 1:
>> +		pci_dbg(pdev, "_DSM not supported\n");
>> +		break;
>> +	case 2:
>> +		pci_dbg(pdev, "_DSM invalid input parameters\n");
>> +		break;
>> +	case 3:
>> +		pci_dbg(pdev, "_DSM communication error\n");
>> +		break;
>> +	case 4:
>> +		pci_dbg(pdev, "_DSM function-specific error 0x%x\n",
>> +			output->function_specific_err);
>> +		break;
>> +	case 5:
>> +		pci_dbg(pdev, "_DSM vendor-specific error 0x%x\n",
>> +			output->vendor_specific_err);
>> +		break;
>> +	default:
>> +		pci_dbg(pdev, "_DSM returned unknown status 0x%x\n",
>> +			output->status);
>> +	}
>> +}
> 
> I tired to compile it and I failed:
> drivers/misc/enclosure.c: In function ‘led_show’:
> drivers/misc/enclosure.c:607:3: error: label at end of compound
> statement default:
>     ^~~~~~~
> drivers/misc/enclosure.c: In function ‘led_set’:
> drivers/misc/enclosure.c:644:3: error: label at end of compound
> statement default:
>     ^~~~~~~
> make[2]: *** [scripts/Makefile.build:288: drivers/misc/enclosure.o]
> Error 1 make[1]: *** [scripts/Makefile.build:550: drivers/misc] Error 2
> make[1]: *** Waiting for unfinished jobs....
> 
> My gcc version:
> gcc (SUSE Linux) 7.5.0
> 
> Could you please, resolve the issue?
> 
> Thanks,
> Mariusz
> 

No problem.  I'll send a v2 now.
Thanks,
Stuart
