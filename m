Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D8FB4699468
	for <lists+linux-pci@lfdr.de>; Thu, 16 Feb 2023 13:34:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229595AbjBPMd7 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 16 Feb 2023 07:33:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229501AbjBPMd7 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 16 Feb 2023 07:33:59 -0500
Received: from esa5.hgst.iphmx.com (esa5.hgst.iphmx.com [216.71.153.144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DDAC305C1
        for <linux-pci@vger.kernel.org>; Thu, 16 Feb 2023 04:33:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1676550838; x=1708086838;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=AAoscuEq2Mi2ZKeNrCC1H02+CXVPiiuyo7hT8RRND2U=;
  b=m7cUw9mUcKw84+dY3PdGT/mCv3x03Po4V8Fi3soNBYPUYoewkz4RcKpV
   nKIWcYEI0djxAKgUVCr9ILxj3vBt57OTmeJBXJ0VzJVOAMU6yO+FDnLDa
   vfNJlzul6eLZ/92hwLOM3hQP19ZvqJ1QBrrftPEPN0gY5sJ1Dr8Ywkio7
   w3Qdt9t9V4NAjSdnghhl1stUY2AV+UbHp348RtDEJ3S5jRao+vtd7M2bh
   wYb/cT4Kgv/GfxheZGV5miGVf9mYOSF04A2KAds9BSfCQgrIEJ585VhI1
   bglxY0ZyYEhVTuto0+OxnGzOmVCAoJlVbKat9rZKfVF7FGlBnRKtQBYvN
   A==;
X-IronPort-AV: E=Sophos;i="5.97,302,1669046400"; 
   d="scan'208";a="223255330"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 16 Feb 2023 20:33:57 +0800
IronPort-SDR: E2GgDv83yYZthsZRuQS6M26V81ovzakq80Va+Lgl+loojFx5ASzvsNjairLZHJpt+wwHSxtUct
 BjktR5RAHpq2hU32RtNBxpzV0mCGaLVZuS1XNB5bmOMP26bk/x4x0lJsvPkfNbwGU6A6GDmwm9
 3gBjPg2o+KOnVjHwBuCFbdMWPFDezSG+fDSI+HzF/GzWCnCDyG+zh9UqyYcvDjmx9hmoDLW97l
 wz1Mg8PxB1HB4uvurdSf+Ciqin58Rzla+Q9Qh9mgCWAbIL1dNgGaYr4OCzK6rmGSlflkK88l7d
 yBY=
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 16 Feb 2023 03:51:02 -0800
IronPort-SDR: j3PTlUC/yR6lTKijelnpcCZX/6bj5hM2QplDnUQxygMckctJHvkYSztt2z1wPIjM9dyzARqEYv
 dcfzZoK6Kv9oHOe2cXztOIUPOmz5x/tn7jpkJDGzcUI1mb+7bqiF8DkE1R8HHQ5yG8lI0mR90s
 zEsQRhHncrKjYRgOE6VzBf4izpxWOhdDkBmm1n5SevRQgFOnGFsb7uCvVkNM//skkNljd8uzEd
 JOeSnOggHI0QgNbxs0MSXeH5B2S303A5VT7cW9F77nzT2aVXKBoRFAjsZQhKwIbmmCCopW15tQ
 zMY=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 16 Feb 2023 04:33:58 -0800
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4PHZBF2288z1RwtC
        for <linux-pci@vger.kernel.org>; Thu, 16 Feb 2023 04:33:57 -0800 (PST)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1676550836; x=1679142837; bh=AAoscuEq2Mi2ZKeNrCC1H02+CXVPiiuyo7h
        T8RRND2U=; b=TiofgcM8++39c/lTr4FAPeN3DJVZ1CB6rAirNRn0SI4sFSR3QXI
        7RMN5swDa/5e8hW1zOX2Hm4vxZDxXoHZOfoi7rwGbCD7MYp+4T8siraOdUURO0Zm
        68RSMHQL6WPNYHLjLHe7hHpVPlXS4JMZjvoFry7L9axwIqJ+VYMqy/yomQW2K0hc
        LVsM0mqfi46oN+it3YgnQ8Wsl5G0ezlIBj1XoUc6Dn8XFICLkyAKTsuRlCL+envG
        PbuRgJIooSvx63X0tH/ByMdjKcskJBSfYZlW/tHQs8FcrNkUC93XKWKs1VYbK7Kr
        aB0wWIqzxfVXZ+/f9hxHImkU3cHlK7zh7NQ==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id GD7nYSgSSewz for <linux-pci@vger.kernel.org>;
        Thu, 16 Feb 2023 04:33:56 -0800 (PST)
Received: from [10.225.163.121] (unknown [10.225.163.121])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4PHZBC2Vr6z1RvLy;
        Thu, 16 Feb 2023 04:33:55 -0800 (PST)
Message-ID: <581bde21-38d1-e8a9-5133-721b734582a7@opensource.wdc.com>
Date:   Thu, 16 Feb 2023 21:33:54 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH 02/12] pci: endpoint: do not export pci_epf_type_add_cfs()
Content-Language: en-US
To:     Manivannan Sadhasivam <mani@kernel.org>
Cc:     Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        Rick Wertenbroek <rick.wertenbroek@gmail.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?UTF-8?Q?Krzysztof_Wilczy=c5=84ski?= <kw@linux.com>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
References: <20230215032155.74993-1-damien.lemoal@opensource.wdc.com>
 <20230215032155.74993-3-damien.lemoal@opensource.wdc.com>
 <20230216101526.GD2420@thinkpad>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <20230216101526.GD2420@thinkpad>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 2/16/23 19:15, Manivannan Sadhasivam wrote:
> On Wed, Feb 15, 2023 at 12:21:45PM +0900, Damien Le Moal wrote:
>> pci_epf_type_add_cfs() is called only from pci_ep_cfs_add_type_group()
>> in drivers/pci/endpoint/pci-ep-cfs.c, so there is no need to export it
>> and function drivers should not call this function directly.
>>
> 
> Where is the pci_ep_cfs_add_type_group() function defined?

In patch 1.


>>  /**
>>   * pci_epf_unbind() - Notify the function driver that the binding between the
>> diff --git a/drivers/pci/endpoint/pci-epf.h b/drivers/pci/endpoint/pci-epf.h
>> new file mode 100644
>> index 000000000000..b2f351afd623
>> --- /dev/null
>> +++ b/drivers/pci/endpoint/pci-epf.h
> 
> When there is already a pci-epf.h header available, creating one more even
> under different location will create ambiguity. Please rename it as internal.h
> or something relevant.

OK.

-- 
Damien Le Moal
Western Digital Research

